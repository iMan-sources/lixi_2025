//
//  IdeaDisplayView.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class IdeaDisplayView: UIView {
    
    //MARK: - Subviews
    private lazy var ideaSampleView: IdeaSampleView = {
        let view = IdeaSampleView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    //MARK: - Properties
    
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
        layout()
    }
}

//MARK: - IdeaDisplayView
private extension IdeaDisplayView {
    func setupUI(){
        backgroundColor = .systemPink
    }
    
    func layout(){
        addSubview(ideaSampleView)
        NSLayoutConstraint.activate([
            ideaSampleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            ideaSampleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ideaSampleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -88)
        ])
    }
}
