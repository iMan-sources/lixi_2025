//
//  IdeaSampleView.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class IdeaSampleView: UIView {
    
    private lazy var sampleIdeaLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Mẫu ý tưởng 💡"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private lazy var ideaScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        return stackView
    }()
    
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

//MARK: - IdeaSampleView
private extension IdeaSampleView {
    func setupUI(){
        
    }
    
    func layout(){
        addSubview(sampleIdeaLabel)
        addSubview(ideaScrollView)
        ideaScrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            sampleIdeaLabel.topAnchor.constraint(equalTo: topAnchor),
            sampleIdeaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            ideaScrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            ideaScrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            ideaScrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            ideaScrollView.topAnchor.constraint(equalTo: sampleIdeaLabel.bottomAnchor, constant: 12)
        ])
        
        heightAnchor.constraint(equalToConstant: 82).isActive = true
    }
}
