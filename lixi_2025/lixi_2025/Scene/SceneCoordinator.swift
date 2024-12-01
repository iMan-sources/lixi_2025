//
//  SceneCoordinator.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa

class SceneCoordinator: SceneCoordinatorType{
    
    private var window: UIWindow
    private var currentViewController: UIViewController
    
    // find actual view controller in view controllers stack
    static func actualViewController(for viewController: UIViewController) -> UIViewController{
        if let navigationController = viewController as? UINavigationController{
            return navigationController.viewControllers.first!
        }else{
            return viewController
        }
    }
    
    init(window: UIWindow) {
        self.window = window
        
        self.currentViewController = window.rootViewController!
    }
    
    @discardableResult
    func transition(to scene: Scene, type: SceneTransitionType) -> Completable {
        // use to notify when coordinate finish
        let subject = PublishSubject<Void>()
        let viewController = scene.viewController()
        
        switch type {
        case .root:
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            window.rootViewController = UINavigationController(rootViewController: viewController)
            subject.onCompleted()
            
        case .push:
            guard let navigationController = currentViewController.navigationController else {
                fatalError("Can't push a view controller without a current navigation controller")
            }
                        
            _ = navigationController
                .rx.delegate // allows to listen to UINavigationControllerDelegate events and methods as an Observable chain.
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:))) // listen #selector and emits events when navigated to other
                .map { _ in} // converted everything to void type
                .bind(to: subject) // assign to subject to emit onCompleted - pushing progress finished
            navigationController.pushViewController(viewController, animated: true)
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        
        case .modal(let presentationStyle):
            viewController.modalPresentationStyle = presentationStyle
            currentViewController.present(viewController, animated: true) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
            
        case .rootModal(let presentationStyle):
            viewController.modalPresentationStyle = presentationStyle
            let nc = UINavigationController(rootViewController: viewController)
            currentViewController.present(nc, animated: true) {
                subject.onCompleted()
            }
            currentViewController = SceneCoordinator.actualViewController(for: viewController)
        }
        
        return subject
            .asObservable()
            .take(1)
            .ignoreElements()
            .asCompletable()
    }
    
    
    
     
    func pop(animated: Bool) -> Completable {
        let subject = PublishSubject<Void>()
        if let presenter = currentViewController.presentingViewController{
            currentViewController.dismiss(animated: true) {
                self.currentViewController = SceneCoordinator.actualViewController(for: presenter)
                subject.onCompleted()
            }
        }else if let navigationController = currentViewController.navigationController{
            _ = navigationController
                .rx.delegate
                .sentMessage(#selector(UINavigationControllerDelegate.navigationController(_:didShow:animated:)))
                .map({ _ in})
                .bind(to: subject)
            
            guard navigationController.popViewController(animated: true) != nil else {
                fatalError("can't navigate back from \(currentViewController)")
            }
            currentViewController = SceneCoordinator.actualViewController(for: navigationController.viewControllers.last!)
        }
        
        return subject
            .asObservable()
            .take(1)
            .ignoreElements()
            .asCompletable()
    }
    
    
}

