//
//  PlaylistResponseModel.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation


struct PlaylistResponseModel: Codable {
    let items: [Item]?
}

struct Item: Codable {
    let snippet: Snippet?
}

struct Snippet: Codable {
    let title, snippetDescription: String?
    let thumbnails: Thumbnails?
    let position: Int?
    let resourceID: ResourceID?

    enum CodingKeys: String, CodingKey {

        case title
        case snippetDescription = "description"
        case thumbnails
        case position
        case resourceID = "resourceId"
    
    }
}

struct ResourceID: Codable {
    let videoID: String?

    enum CodingKeys: String, CodingKey {
        case videoID = "videoId"
    }
}

struct Thumbnails: Codable {
    let thumbnailsDefault, medium, high, standard: ThumbURL?

    enum CodingKeys: String, CodingKey {
        case thumbnailsDefault = "default"
        case medium, high, standard
    }
}

struct ThumbURL: Codable {
    let url: String?
    let width, height: Int?
}
