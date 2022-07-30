//
//  HomeRequestModel.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import Foundation

struct HomeRequestModel:Encodable{
    
    private var part:String = "snippet"
    private var playlistId:String = "PLKrpEodZXM8iZWTA8C49aQOUS6YWnspcQ"
    private var key = NetworkConfiguration.API_KEY
    var maxResults:Int = 50
    

}
