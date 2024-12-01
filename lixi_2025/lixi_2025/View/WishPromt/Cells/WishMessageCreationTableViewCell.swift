//
//  WishMessageCreatingTableViewCell.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class WishMessageCreationTableViewCell: UITableViewCell, ReusableView {
    
    //MARK: - Subviews
    private lazy var creationButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tạo lời chúc", for: .normal)
        button.backgroundColor = .systemRed
        return button
    }()
    //MARK: - Properties
    static let bottomPadding: CGFloat = 40.0
    static var buttonHeight: CGFloat = 48.0
    
    static var cellHeight: CGFloat{
        return bottomPadding + buttonHeight
    }
    //MARK: - Lifecycle
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - WishMessageCreatingTableViewCell
private extension WishMessageCreationTableViewCell {
    func setupUI(){
        selectionStyle = .none
        creationButton.layer.cornerRadius = WishMessageCreationTableViewCell.buttonHeight / 2
    }
    
    func layout(){
        contentView.addSubview(creationButton)
        NSLayoutConstraint.activate([
            creationButton.topAnchor.constraint(equalTo: contentView.topAnchor),
            creationButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            creationButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            creationButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -WishMessageCreationTableViewCell.bottomPadding),
            creationButton.heightAnchor.constraint(equalToConstant: WishMessageCreationTableViewCell.buttonHeight)
        ])
    }
}
