//
//  HomeError.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation

enum CustomError:Error{
    case InternetError
    case ServerError
    case custom(ErrorType)
}
extension CustomError:CustomStringConvertible{
    var description: String {
        switch self {
        case .InternetError:
            return "No Internet Connection, Please try again later..."
        case .ServerError:
            return "An Error Occured try again later"
        case .custom(let str):
            return str.message ?? "an error occured"
        }
    }
    
    
}
