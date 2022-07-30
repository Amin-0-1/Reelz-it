//
//  VideoCell.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import UIKit
import AVFoundation
import YouTubeiOSPlayerHelper
class VideoCell: UICollectionViewCell {

    
    
    @IBOutlet weak var youtubeView: YTPlayerView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        youtubeView.stopVideo()
    }

    func configureCell(model:Snippet){
        guard let id = model.resourceID?.videoID else {return}
        youtubeView.load(withVideoId: id)
        youtubeView.playVideo()
    }
}
