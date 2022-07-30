//
//  HomeTarget.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation
import Moya

enum HomeTarget{
    case fetch(HomeRequestModel)
}

extension HomeTarget:TargetType{
    var baseURL: URL {
        return URL(string: NetworkConfiguration.BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .fetch:
            return HomeNetworkPath.Playlist.rawValue
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fetch:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .fetch(let homeRequestModel):
            return .requestParameters(parameters: homeRequestModel.dictionary ?? [:] , encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
    
}
