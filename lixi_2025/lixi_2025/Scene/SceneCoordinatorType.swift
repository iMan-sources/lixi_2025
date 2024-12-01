//
//  SceneCoordinatorType.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import RxSwift
import UIKit

protocol SceneCoordinatorType{
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable
    
    func pop(animated: Bool) -> Completable
}

extension SceneCoordinatorType{
    func pop() -> Completable{
        return pop(animated: true)
    }
}
