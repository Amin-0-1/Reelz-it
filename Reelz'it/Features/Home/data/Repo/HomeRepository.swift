//
//  HomeRepository.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation
import Moya


class HomeRepository:RepositoryInterface{
    
    private var remote:MoyaProvider<HomeTarget>!
    init(remote:MoyaProvider<HomeTarget>){
        self.remote = remote
    }
    
    
    func fetch(request: HomeRequestModel, completion: @escaping (Result<PlaylistResponseModel, CustomError>) -> Void) {
        remote.request(.fetch(request)) { result in
            switch result{
            case .failure(_):
                completion(.failure(.InternetError))
            case .success(let response):
                
                guard let decoded = try? JSONDecoder().decode(PlaylistResponseModel.self, from: response.data),let _ = decoded.items else {
                    
                    guard let errorDecoded = try? JSONDecoder().decode(ErrorResponseModel.self, from: response.data) else{return}
                    
                    guard let error = errorDecoded.error else {return}
                    completion(.failure(.custom(error)))
                    return
                }
                completion(.success(decoded))
                
            }
        }
    }
}
