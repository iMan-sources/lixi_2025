//
//  DisplayIdeaViewController.swift
//  lixi_2025
//
//  Created by Build ios on 2/12/24.
//

import UIKit
import RxSwift
class DisplayIdeaViewController: UIViewController, BindableType {
    
    typealias ViewModelType = DisplayIdeaProtocol
    
    private lazy var ideaSampleView: IdeaSampleView = {
        let view = IdeaSampleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var viewModel: ViewModelType!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        layout()
        
    }
    
    func bindViewModel() {
        viewModel.samplesToDisplay.asObservable().subscribe(onNext: {[weak self] samples in
            self?.ideaSampleView.updateSampleWishesList(with: samples)
        }).disposed(by: disposeBag)
    }
    
}

//MARK: - DisplayIdeaViewController
private extension DisplayIdeaViewController {
    func setupUI(){
        self.view.backgroundColor = .systemBlue
    }
    
    func layout(){
        
        self.view.addSubview(ideaSampleView)
        let ideaSampleViewTrailingConstraint = ideaSampleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ideaSampleViewTrailingConstraint.priority = .defaultHigh
        NSLayoutConstraint.activate([
            ideaSampleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            ideaSampleViewTrailingConstraint,
            ideaSampleView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -88)
        ])
        
    }
}


