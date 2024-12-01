//
//  BindableType.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit

protocol BindableType: AnyObject{
    associatedtype ViewModelType
    var viewModel: ViewModelType! {get set}
    func bindViewModel()
}

extension BindableType where Self: UIViewController{
    func bindViewModel(to model: Self.ViewModelType){
        viewModel = model
        loadViewIfNeeded()
        bindViewModel()
    }
}
