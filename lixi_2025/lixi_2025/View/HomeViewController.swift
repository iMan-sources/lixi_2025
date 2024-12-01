//
//  ViewController.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit

class HomeViewController: UIViewController, BindableType {
    
    //MARK: - Typealisas
    typealias ViewModelType = HomeVMProtocol
    
    //MARK: - Subviews
    
    private lazy var modalButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Next", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(didTapModalButton(_:)), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Properties
    var viewModel: HomeVMProtocol!
    
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        layout()
    }
    
    //MARK: - Action
    @objc func didTapModalButton(_ sender: UIButton){
        viewModel.onPresentWishPromptVC()
    }
    //MARK: - Helpers
    func bindViewModel() {
        
    }
}

//MARK: - HomeViewController
private extension HomeViewController{
    func setupUI(){
        self.view.backgroundColor = .white
        self.title = "SandBox"
    }
    
    func layout(){
        self.view.addSubview(modalButton)
        NSLayoutConstraint.activate([
            modalButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            modalButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
}

