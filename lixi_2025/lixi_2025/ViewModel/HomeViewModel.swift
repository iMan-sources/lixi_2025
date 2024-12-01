//
//  HomeViewModel.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import Foundation

protocol HomeVMProtocol{
    func onPresentWishPromptVC()
}
struct HomeViewModel: HomeVMProtocol{
    let sceneCoordinator: SceneCoordinatorType

    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
    
    func onPresentWishPromptVC() {
        let wishPromptVM = WishPromtViewModel(sceneCoordinator: sceneCoordinator)
        let scene = Scene.promt(wishPromptVM)
        _ = sceneCoordinator.transition(to: scene, type: .rootModal(.formSheet))
    }
    
    
    
    
}
