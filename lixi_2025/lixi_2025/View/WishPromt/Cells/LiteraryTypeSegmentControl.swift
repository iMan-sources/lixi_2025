//
//  LiteraryTypeSegmentControl.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class LiteraryTypeSegmentControl: UIView {
    
    //MARK: - Properties
    private var buttons: [UIButton] = []
    private var titles: [String]
    
    //MARK: - Subviews
    private lazy var selectorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var horizontalStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    var selectedButton: UIButton? {
        didSet{
            guard let selectedButton = selectedButton else {
                fatalError("selected button not set")
            }
            var duration = 0.3
            if oldValue == nil{
                duration = 0.0
            }
            
            let width = selectedButton.frame.width - 16
            let height = selectedButton.frame.height - 16
            let newX = selectedButton.frame.midX - width / 2
            let newY = selectedButton.frame.midY - height / 2
            
            UIView.animate(withDuration: duration) {
                self.selectorView.frame = CGRect(x: newX, y: newY, width: width, height: height)
            } completion: { _ in
                oldValue?.isSelected = false
                selectedButton.isSelected = true
            }
            
            // send delegate if need
            
        }
    }
    
    //MARK: - Lifecycle
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        self.titles = []
        super.init(coder: coder)
        setupUI()
        layout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if selectedButton == nil || selectedButton == buttons.first {
            selectedButton = buttons.first
        }
    }
    
    //MARK: - Actions
    @objc func buttonTapped(_ sender: UIButton){
        guard sender != selectedButton else { return }
        selectedButton = sender
    }    
}

//MARK: - LiteraryTypeSegmentControl
private extension LiteraryTypeSegmentControl {
    func setupButtons(in stackView: UIStackView){
        for title in self.titles {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.titleLabel?.backgroundColor = .clear
            button.setTitleColor(.black, for: .normal)
            button.setTitleColor(.cyan, for: .selected)
            
            button.backgroundColor = .clear
            button.tintColor = .clear
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
            buttons.append(button)
        }
    }
    
    func setupUI(){
        
    }
    
    func layout(){
        addSubview(selectorView)
        
        addSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStack.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        setupButtons(in: horizontalStack)
    }
}
