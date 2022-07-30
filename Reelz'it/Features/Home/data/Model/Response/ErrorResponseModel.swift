//
//  ErrorResponseModel.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation


struct ErrorResponseModel: Codable {
    let error: ErrorType?
}

// MARK: - ErrorResponseModelError
struct ErrorType: Codable {
    let code: Int?
    let message: String?
    let status: String?
}
