//
//  AppCoordinator.swift
//  Reelz'it
//
//  Created by Amin on 28/07/2022.
//

import UIKit

protocol Coordinating{
    func start()
}

struct AppCoordinator:Coordinating{
    private var window:UIWindow!
    init(window:UIWindow){
        self.window = window
    }
    func start() {
        let HomeCoordinator = HomeCoordinator(window: window)
        HomeCoordinator.start()
    }
}
