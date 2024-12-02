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
    
    private lazy var contentView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(IdeaContentCollectionViewCell.self, forCellWithReuseIdentifier: IdeaContentCollectionViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private var samples: [String] = []
    
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
    
    func updateSampleWishesList(with samples: [String]){
        self.samples = samples
        contentView.reloadData()
    }
    
}

//MARK: - IdeaSampleView
private extension IdeaSampleView {
    func setupUI(){
        
    }
    
    func layout(){
        addSubview(sampleIdeaLabel)
        addSubview(contentView)
        NSLayoutConstraint.activate([
            sampleIdeaLabel.topAnchor.constraint(equalTo: topAnchor),
            sampleIdeaLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ])
        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: sampleIdeaLabel.bottomAnchor, constant: 12),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
        
        heightAnchor.constraint(equalToConstant: 82).isActive = true
        
    }
}

extension IdeaSampleView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 52)
    }
}

extension IdeaSampleView: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return samples.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: IdeaContentCollectionViewCell.identifier, for: indexPath) as? IdeaContentCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.addSample(withSample: samples[indexPath.row])
        return cell
    }
}


