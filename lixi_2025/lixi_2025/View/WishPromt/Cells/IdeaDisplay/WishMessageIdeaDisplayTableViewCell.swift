//
//  WishMessageIdeaTableViewCell.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class WishMessageIdeaDisplayTableViewCell: UITableViewCell, ReusableView {
    
    private lazy var mainView: IdeaDisplayView = {
        let view = IdeaDisplayView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
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

//MARK: - WishMessageIdeaTableViewCell
private extension WishMessageIdeaDisplayTableViewCell {
    func setupUI(){
        selectionStyle = .none
    }
    
    func layout(){
        contentView.addSubview(mainView)
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}
