//
//  HomeCoordinator.swift
//  Reelz'it
//
//  Created by Amin on 28/07/2022.
//

import UIKit
import Moya
protocol HomeCoordinating:Coordinating{
    
}

struct HomeCoordinator:HomeCoordinating{
    private var window:UIWindow!
    init(window:UIWindow){
        self.window = window
    }
    
    func start() {
        let vc = HomeVC.init(nibName: R.nib.homeVC.name, bundle: nil)
        let moya = MoyaProvider<HomeTarget>(plugins:[NetworkLoggerPlugin()])
        let repo = HomeRepository(remote: moya)
        let usecase = HomeUsecase(repo: repo)
        vc.viewModel = HomeViewModel(usecase: usecase)
        window.rootViewController = vc
        window.makeKeyAndVisible()
    }
}
