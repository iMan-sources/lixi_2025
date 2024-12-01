//
//  WishMessageComponentsTableViewCell.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class WishMessageComponentsTableViewCell: UITableViewCell, ReusableView {
    
    
    static let bottomPadding: CGFloat = 12.0
    static let textViewHeight: CGFloat = 56.0
    static let topPaddingAtRecipientCell: CGFloat = 16.0
    static var cellHeight: CGFloat{
        return bottomPadding + textViewHeight
    }
    private var topConstraint: NSLayoutConstraint!
    private lazy var textfield: UITextField = {
        let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        textfield.layer.cornerRadius = 16
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.lightGray.cgColor
        return textfield
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateUI(withComponents components: WishPromtViewModel.WishPromtType){
        textfield.placeholder = components.defaultText
        topConstraint.constant = components == .recipient ? WishMessageComponentsTableViewCell.topPaddingAtRecipientCell : 0.0
    }
    
}


//MARK: - WishMessageComponentsTableViewCell
private extension WishMessageComponentsTableViewCell {
    func setupUI(){
        selectionStyle = .none
    }
    
    func layout(){
        contentView.addSubview(textfield)
        topConstraint = textfield.topAnchor.constraint(equalTo: contentView.topAnchor)
        NSLayoutConstraint.activate([
            textfield.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textfield.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            topConstraint!,
            textfield.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -WishMessageComponentsTableViewCell.bottomPadding),
            textfield.heightAnchor.constraint(equalToConstant: WishMessageComponentsTableViewCell.textViewHeight)
        ])
    }
}

extension WishMessageComponentsTableViewCell: UITextFieldDelegate{
    
}
