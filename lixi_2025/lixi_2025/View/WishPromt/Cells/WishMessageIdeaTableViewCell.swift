//
//  WishMessageIdeaTableViewCell.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class WishMessageIdeaTableViewCell: UITableViewCell, ReusableView {

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
private extension WishMessageIdeaTableViewCell {
    func setupUI(){
        selectionStyle = .none
    }
    
    func layout(){
        
    }
}
