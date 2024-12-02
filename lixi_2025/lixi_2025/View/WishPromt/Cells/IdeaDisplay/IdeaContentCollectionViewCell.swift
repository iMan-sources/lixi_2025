//
//  IdeaContentCollectionViewCell.swift
//  lixi_2025
//
//  Created by Build ios on 2/12/24.
//

import UIKit

class IdeaContentCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private lazy var ideaLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    func addSample(withSample sample: String){
        ideaLabel.text = sample
    }
    
}

private extension IdeaContentCollectionViewCell{
    func setupUI(){
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .systemOrange
    }
    
    func layout(){
        contentView.addSubview(ideaLabel)
        NSLayoutConstraint.activate([
            ideaLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            ideaLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            ideaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            ideaLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
        ])
    }
}
