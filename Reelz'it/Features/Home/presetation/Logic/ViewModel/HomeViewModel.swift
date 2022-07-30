//
//  HomeViewModel.swift
//  Reelz'it
//
//  Created by Amin on 28/07/2022.
//

import Foundation
import RxSwift
import RxCocoa



class HomeViewModel:HomeViewModelProtocol{
    var input: HomeVMInput!
    var output: HomeVMOutput!
    
    private var usecase:HomeUsecaseProtocol!
    private var bag:DisposeBag!
    private var relayData:BehaviorRelay<[Snippet]>!
    init(usecase:HomeUsecaseProtocol){
        self.usecase = usecase
        input = HomeVMInput()
        output = HomeVMOutput()
        bag = DisposeBag()
        bind()
        relayData = BehaviorRelay(value: [])
    }
    
    private func bind(){
        input.onScreenAppeared.bind{ [weak self] _ in
            guard let self = self else {return}
            self.output.showLoadingSubject.onNext(())
            self.usecase.fetch { list in
                self.output.hideLoadingSubject.onNext(())
                self.relayData.accept(list)
                self.output.onFinishFetchingSubj.onNext(list.count)
            } onFailure: { error in
//                self.output.hideLoadingSubject.onNext(())
                self.output.showErrorSubject.onNext(error)
                print(error)
            }

        }.disposed(by: bag)
        
        input.configureCell.bind{ [weak self] cell,indexPath in
            guard let self = self else {return}
            
            let model = self.relayData.value[indexPath.item]

            cell.configureCell(model: model)
        }.disposed(by: bag)
        input.didSelectItemAt.bind{ [weak self] indexPath in
            guard let self = self else {return}
            let model = self.relayData.value[indexPath.item]
            guard let id = model.resourceID?.videoID else {return}
            self.output.showingVideoSubject.onNext(id)
        }.disposed(by: bag)
    }    
}


struct HomeVMOutput:HomeOutput{
    var showLoading: Driver<Void>
    var hideLoading: Driver<Void>
    var showError: Driver<String>
    
    var showingVideo: Observable<String>
    var onFinishFetching: Driver<Int>
    
    fileprivate var onFinishFetchingSubj: PublishSubject<Int>
    fileprivate var showingVideoSubject: PublishSubject<String>
    fileprivate var showLoadingSubject: PublishSubject<Void>
    fileprivate var showErrorSubject: PublishSubject<String>
    fileprivate var hideLoadingSubject:PublishSubject<Void>
    init(){
        onFinishFetchingSubj = PublishSubject()
        onFinishFetching = onFinishFetchingSubj.asDriver(onErrorJustReturn: 0)
        showingVideoSubject = PublishSubject()
        showingVideo = showingVideoSubject.asObservable()
        
        showLoadingSubject = PublishSubject()
        showErrorSubject = PublishSubject()
        hideLoadingSubject = PublishSubject()
        
        showLoading = showLoadingSubject.asDriver(onErrorJustReturn: ())
        hideLoading = hideLoadingSubject.asDriver(onErrorJustReturn: ())
        showError = showErrorSubject.asDriver(onErrorJustReturn: "")
    }

}
