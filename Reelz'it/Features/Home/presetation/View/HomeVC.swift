//
//  HomeVC.swift
//  Reelz'it
//
//  Created by Amin on 28/07/2022.
//

import UIKit
import RxCocoa
import RxSwift
import YouTubeiOSPlayerHelper
import SFSafeSymbols
import SwiftMessages
import ProgressHUD

class HomeVC: UIViewController{

    
    @IBOutlet weak var uiYoutubeView: YTPlayerView!
    @IBOutlet weak var uiCollectionView: UICollectionView!
    @IBOutlet weak var uiScribbleImage: UIImageView!
    
    var viewModel:HomeViewModelProtocol!
    private var modelCount = 0
    private var bag:DisposeBag!
    override func viewDidLoad() {
        super.viewDidLoad()
        bag = DisposeBag()
        bind()
        configureCollection()
        viewModel.input.onScreenAppeared.onNext(())
    }
    
    private func bind(){
        viewModel.output.onFinishFetching.asObservable().bind{[weak self] count in
            guard let self = self else {return}
            self.modelCount = count
            self.uiCollectionView.reloadData()
            self.uiCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .top)
        }.disposed(by: self.bag)
        
        viewModel.output.showingVideo.bind{ [weak self] id in
            guard let self = self else {return}
            self.uiScribbleImage.image = nil
            self.showVideo(withID: id)
        }.disposed(by: bag)
        
        viewModel.output.hideLoading.asObservable().bind{ _ in
            ProgressHUD.dismiss()
        }.disposed(by: bag)
        viewModel.output.showError.asObservable().bind{ msg in
            ProgressHUD.showError(msg)
        }.disposed(by: bag)
        
        viewModel.output.showLoading.asObservable().bind{  _ in
            ProgressHUD.showProgress(1)
            ProgressHUD.colorProgress = .red
            
        }.disposed(by: bag)
    }

    private func showVideo(withID id:String){
        uiYoutubeView.transform = CGAffineTransform(scaleX: 0, y: 0)
        self.uiYoutubeView.load(withVideoId: id)
        self.uiYoutubeView.playVideo()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else {return}
            UIView.transition(with: self.view, duration: 1, options: .curveEaseInOut) {
                self.uiYoutubeView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    private func configureCollection(){
        
        uiCollectionView.collectionViewLayout = generateLayout()
        let nib = UINib(nibName: R.nib.reelsCell.name, bundle: nil)
        uiCollectionView.register(nib, forCellWithReuseIdentifier:R.reuseIdentifier.reelS_Cell.identifier)
        
    }
    private func generateLayout()->UICollectionViewLayout{
        let layout = UICollectionViewCompositionalLayout(sectionProvider: { section, _ in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: itemSize, subitem: item, count: 2)
            let section = NSCollectionLayoutSection(group: group)
            section.orthogonalScrollingBehavior = .groupPaging
            return section
        })
        return layout
    }
}

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return modelCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.reelS_Cell, for: indexPath) else {fatalError()}
        viewModel.input.configureCell.onNext((cell,indexPath))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.input.didSelectItemAt.onNext(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let animationDuration: Double = 1.0
        cell.alpha = 0.1
        cell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(withDuration: animationDuration, delay: 0.1, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: [], animations: {
            cell.alpha = 1
            cell.transform = .identity
        })
    }

}

