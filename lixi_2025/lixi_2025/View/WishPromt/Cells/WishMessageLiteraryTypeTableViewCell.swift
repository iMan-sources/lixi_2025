//
//  WishMessageLiteraryTypeTableViewCell.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 1/12/24.
//

import UIKit

class WishMessageLiteraryTypeTableViewCell: UITableViewCell, ReusableView {
    
    //MARK: - Properties
    static let bottomPadding: CGFloat = 16.0
    static let segmentControlViewHeight: CGFloat = 56.0
    static var cellHeight: CGFloat{
        return bottomPadding + segmentControlViewHeight
    }
    
    private var titles: [String] = []
    //MARK: - Subviews
    private var segmentControlView: LiteraryTypeSegmentControl = {
        let view = LiteraryTypeSegmentControl(frame: .zero, 
                                              titles: WishPromtViewModel.WishMessageLiteraryType.allCases.map({$0.rawValue}))
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - WishMessageLiteraryTypeTableViewCell
private extension WishMessageLiteraryTypeTableViewCell {
    func setupUI(){
        selectionStyle = .none
    }
    
    func layout(){
        contentView.addSubview(segmentControlView)
        NSLayoutConstraint.activate([
            segmentControlView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            segmentControlView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            segmentControlView.topAnchor.constraint(equalTo: contentView.topAnchor),
            segmentControlView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -WishMessageLiteraryTypeTableViewCell.bottomPadding),
            segmentControlView.heightAnchor.constraint(equalToConstant: WishMessageLiteraryTypeTableViewCell.segmentControlViewHeight)
        
        
        ])
    }
}
