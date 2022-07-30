//
//  HomeVMContract.swift
//  Reelz'it
//
//  Created by Amin on 28/07/2022.
//

import RxSwift
import RxCocoa
import UIKit

protocol HomeInput{
    var onScreenAppeared: PublishSubject<Void>{get}
    var configureCell: PublishSubject<(ReelsCell,IndexPath)>{get}
    var didSelectItemAt: PublishSubject<IndexPath>{get}
}
struct HomeVMInput:HomeInput{
    var didSelectItemAt: PublishSubject<IndexPath>
    var configureCell: PublishSubject<(ReelsCell,IndexPath)>
    var onScreenAppeared: PublishSubject<Void>
    
    init(){
        onScreenAppeared = PublishSubject()
        configureCell = PublishSubject()
        didSelectItemAt = PublishSubject()
    }
    
}
protocol HomeOutput{
    var onFinishFetching:Driver<Int> {get}
    var showingVideo:Observable<String> {get}
    var showLoading:Driver<Void>{get}
    var hideLoading:Driver<Void>{get}
    var showError:Driver<String>{get}
}

protocol HomeViewModelProtocol{
    var input:HomeVMInput! {get}
    var output:HomeVMOutput! {get}
}

