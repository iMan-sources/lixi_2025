//
//  WishPromtNavigationLeftView.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit
import RxSwift
import RxCocoa
class WishPromtNavigationLeftView: UIView{
    
    //MARK: - Subviews
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "arrow.backward"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.rx.tap.bind(to: buttonTapped).disposed(by: disposeBag)
        button.tintColor = .black
        return button
    }()
    
    private lazy var aiImageView: UIImageView = {
        let image = UIImage(systemName: "sparkles")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .systemRed
        return imageView
    }()
    
    private lazy var aiTitle: UILabel = {
        let label = UILabel()
        label.text = "Lời chúc AI"
        label.font = .boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Properties
    let buttonTapped = PublishSubject<Void>()
    private let disposeBag = DisposeBag()
    //MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - WishPromtNavigationLeftView
private extension WishPromtNavigationLeftView {
    func setupUI(){
        
    }
    
    func layout(){
        addSubview(mainStackView)
        mainStackView.addArrangedSubview(backButton)
        mainStackView.addArrangedSubview(aiTitle)
        mainStackView.addArrangedSubview(aiImageView)
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        
        ])
    }
}
