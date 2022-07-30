//
//  ReelsCell.swift
//  Reelz'it
//
//  Created by Amin on 29/07/2022.
//

import UIKit
import SDWebImage
import RxSwift
class ReelsCell: UICollectionViewCell {
    @IBOutlet weak var uiView: UIView!
    @IBOutlet weak var uiImage: UIImageView!
    @IBOutlet weak var uiTitle: UILabel!
    
    private var bag:DisposeBag!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(model:Snippet){
        uiView.layer.cornerRadius = 20
        uiView.layer.borderColor = UIColor.darkGray.cgColor
        uiView.layer.borderWidth = 0.3
    
        
        uiTitle.text = model.title
        guard let image = model.thumbnails?.high?.url,let url = URL(string: image) else {return}
        print(image)
        uiImage.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        uiImage.sd_imageIndicator?.startAnimatingIndicator()
        uiImage.sd_setImage(with: url)
    }

}
