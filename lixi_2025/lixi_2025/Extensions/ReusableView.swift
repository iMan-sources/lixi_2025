//
//  ReusableView.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import Foundation


protocol ReusableView{
    static var identifier: String {get}
}

extension ReusableView{
    static var identifier: String{
        return String(describing: self)
    }
}
