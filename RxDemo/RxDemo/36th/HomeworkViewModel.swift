//
//  HomeworkViewModel.swift
//  RxDemo
//
//  Created by 한수빈 on 2/19/25.
//

import Foundation
import RxCocoa
import RxSwift

final class HomeworkViewModel {
    
    struct Input {
        let itemSelected: ControlEvent<IndexPath>
        let searchTapped: Observable<ControlProperty<String>.Element>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let personList: BehaviorRelay<[Person]>
        let selectedUserList: PublishRelay<[Person]>
    }
    
    private var selectedUsers = [Person]()
    private lazy var filteredUsers = sampleUsers
    private let disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        let personList = BehaviorRelay(value: sampleUsers)
        let selectedUserList = PublishRelay<[Person]>()
        
        input.searchText
            .bind(with: self, onNext: { owner, value in
                if value.isEmpty {
                    owner.filteredUsers = owner.sampleUsers
                    personList.accept(owner.filteredUsers)
                }
            })
            .disposed(by: disposeBag)
        
        input.itemSelected
            .withUnretained(self)
            .map { owner, indexPath in
                return owner.filteredUsers[indexPath.row]
            }
            .bind(with: self) { owner, item in
                owner.selectedUsers.insert(item, at: 0)
                selectedUserList.accept(owner.selectedUsers)
            }
            .disposed(by: disposeBag)
        
        input.searchTapped
            .bind(with: self) { owner, value in
                let text = value.trimmingCharacters(in: .whitespacesAndNewlines)
                owner.filteredUsers = text.isEmpty ? owner.sampleUsers : owner.sampleUsers.filter {
                    $0.name.contains(text)
                }
                personList.accept(owner.filteredUsers)
            }
            .disposed(by: disposeBag)
        
        return Output(
            personList: personList,
            selectedUserList: selectedUserList
        )
        
    }
    
    private let sampleUsers: [Person] = [
        Person(name: "Steven", email: "steven.brown@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/1.jpg"),
        Person(name: "Mike", email: "mike.wilson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/2.jpg"),
        Person(name: "Emma", email: "emma.taylor@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/1.jpg"),
        Person(name: "James", email: "james.anderson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/3.jpg"),
        Person(name: "Lisa", email: "lisa.martin@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/2.jpg"),
        Person(name: "John", email: "john.davis@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/4.jpg"),
        Person(name: "Sarah", email: "sarah.white@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/3.jpg"),
        Person(name: "David", email: "david.miller@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/5.jpg"),
        Person(name: "Laura", email: "laura.jones@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/4.jpg"),
        Person(name: "Tom", email: "tom.wilson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/6.jpg"),
        Person(name: "Amy", email: "amy.clark@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/5.jpg"),
        Person(name: "Paul", email: "paul.harris@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/7.jpg"),
        Person(name: "Karen", email: "karen.lewis@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/6.jpg"),
        Person(name: "Mark", email: "mark.lee@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/8.jpg"),
        Person(name: "Helen", email: "helen.young@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/7.jpg"),
        Person(name: "Ryan", email: "ryan.walker@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/9.jpg"),
        Person(name: "Lucy", email: "lucy.hall@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/8.jpg"),
        Person(name: "Eric", email: "eric.allen@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/10.jpg"),
        Person(name: "Kate", email: "kate.king@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/9.jpg"),
        Person(name: "Brian", email: "brian.scott@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/11.jpg"),
        Person(name: "Nancy", email: "nancy.green@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/10.jpg"),
        Person(name: "Chris", email: "chris.baker@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/12.jpg"),
        Person(name: "Diana", email: "diana.adams@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/11.jpg"),
        Person(name: "Kevin", email: "kevin.hill@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/13.jpg"),
        Person(name: "Julia", email: "julia.wright@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/12.jpg"),
        Person(name: "Gary", email: "gary.nelson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/14.jpg"),
        Person(name: "Rachel", email: "rachel.carter@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/13.jpg"),
        Person(name: "Frank", email: "frank.mitchell@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/15.jpg"),
        Person(name: "Alice", email: "alice.perez@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/14.jpg"),
        Person(name: "Scott", email: "scott.roberts@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/16.jpg"),
        Person(name: "Maria", email: "maria.turner@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/15.jpg"),
        Person(name: "Peter", email: "peter.phillips@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/17.jpg"),
        Person(name: "Sandra", email: "sandra.campbell@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/16.jpg"),
        Person(name: "Jeff", email: "jeff.parker@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/18.jpg"),
        Person(name: "Paula", email: "paula.evans@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/17.jpg"),
        Person(name: "Doug", email: "doug.edwards@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/19.jpg"),
        Person(name: "Linda", email: "linda.collins@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/18.jpg"),
        Person(name: "Steve", email: "steve.stewart@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/20.jpg"),
        Person(name: "Carol", email: "carol.morris@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/19.jpg"),
        Person(name: "Dan", email: "dan.rogers@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/21.jpg"),
        Person(name: "Ruth", email: "ruth.reed@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/20.jpg"),
        Person(name: "Greg", email: "greg.cook@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/22.jpg"),
        Person(name: "Betty", email: "betty.morgan@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/21.jpg"),
        Person(name: "Alex", email: "alex.bell@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/23.jpg"),
        Person(name: "Janet", email: "janet.murphy@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/22.jpg"),
        Person(name: "Phil", email: "phil.bailey@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/24.jpg"),
        Person(name: "Judy", email: "judy.rivera@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/23.jpg"),
        Person(name: "Larry", email: "larry.cooper@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/25.jpg"),
        Person(name: "Rose", email: "rose.richardson@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/24.jpg"),
        Person(name: "Ralph", email: "ralph.cox@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/men/26.jpg"),
        Person(name: "Ann", email: "ann.howard@example.com", profileImage: "https://randomuser.me/api/portraits/thumb/women/25.jpg")
    ]
    
}
