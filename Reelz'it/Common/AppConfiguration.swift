//
//  AppConfiguration.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation

class AppConfig{
    private static let youtubeURL = "https://www.youtube.com/watch?v="
    static func generateYoutubeURL(withID id:String)->URL?{
        let str = youtubeURL + id
        return URL(string: str) 
    }
}
