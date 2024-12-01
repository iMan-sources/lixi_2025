//
//  Scene+ViewController.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit

/// Initialize viewcontroller

extension Scene{
    func viewController() -> UIViewController{
        switch self {
        case .home(let homeViewModel):
            let vc = HomeViewController()
            vc.bindViewModel(to: homeViewModel)
            return vc
            
        case .promt(let wishPromtViewModel):
            let vc = WishPromptViewController()
            vc.bindViewModel(to: wishPromtViewModel)
            return vc
        }
    }
}

