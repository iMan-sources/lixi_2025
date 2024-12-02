//
//  DisplayIdeaViewModel.swift
//  lixi_2025
//
//  Created by Build ios on 2/12/24.
//

import UIKit
import RxSwift
import RxRelay
protocol DisplayIdeaProtocol: AnyObject{
    var samplesToDisplay: PublishRelay<[String]> {get set}
}

class DisplayIdeaViewModel: DisplayIdeaProtocol{
    var samplesToDisplay: PublishRelay<[String]> = PublishRelay()

}
