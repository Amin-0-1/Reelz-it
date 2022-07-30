//
//  Codable.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation

extension Encodable{
    var dictionary:[String:Any]?{
        guard let data = try? JSONEncoder().encode(self) else {return nil}
        return (try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)).flatMap{$0 as? [String:Any]}
    }
}
