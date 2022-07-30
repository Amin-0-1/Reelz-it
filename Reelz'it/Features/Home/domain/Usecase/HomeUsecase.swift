//
//  HomeVMUsecase.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation

protocol HomeUsecaseProtocol{
    func fetch(onSuccess:@escaping ([Snippet])->Void,onFailure: @escaping(String)->Void)
}

class HomeUsecase:HomeUsecaseProtocol{

    private var repo:RepositoryInterface!
    init(repo:RepositoryInterface){
        self.repo = repo
    }
    
    func fetch(onSuccess: @escaping ([Snippet]) -> Void, onFailure: @escaping (String) -> Void) {
        let request = HomeRequestModel()

        repo.fetch(request: request) { result in
            switch result{
            case .success(let response):
                guard let items = response.items else {onSuccess([]);return}
                var snipet = [Snippet]()
                snipet = items.compactMap{$0.snippet}
                onSuccess(snipet)
            case .failure(let error):
                onFailure(error.description)

            }
        }
    }
    
    
}
