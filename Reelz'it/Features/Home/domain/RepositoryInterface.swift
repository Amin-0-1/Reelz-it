//
//  RepositoryInterface.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation

protocol RepositoryInterface{
    func fetch(request:HomeRequestModel,completion:@escaping(Result<PlaylistResponseModel,CustomError>)->Void)
}
