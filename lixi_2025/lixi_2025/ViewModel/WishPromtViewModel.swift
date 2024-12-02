//
//  WishPromtViewModel.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit
import RxSwift
import RxRelay
protocol WishPromtVMProtocol{
    func onDismiss()
    func numberOfRowsInSection(_ section: Int) -> Int
}
struct WishPromtViewModel: WishPromtVMProtocol{
    
    enum WishPromtType: CaseIterable, Equatable{
        static var allCases: [WishPromtViewModel.WishPromtType]{
            return [.ideaDisplay, .recipient, .wishMessage, .aiSuggestion, .literaryTypes(.prose), .actions(.creating)]
        }
        
        case ideaDisplay
        case recipient
        case wishMessage
        case aiSuggestion
        case literaryTypes(WishMessageLiteraryType)
        case actions(WishMessageActions)
        
        var defaultText: String?{
            switch self {
            case .recipient:
                return "Người nhận (bố mẹ/ bạn bè/ tên riêng...)"
            case .wishMessage:
                return "Kỷ niệm, cảm xúc, lời chúc dành cho người nhận"
            case .aiSuggestion:
                return "Gợi ý thêm cho AI"
            default:
                return nil
            }
        }
    }
    
    enum WishMessageLiteraryType: String, CaseIterable{
        case prose = "Văn xuôi"
        case poetry = "Bài thơ"
    }
    
    enum WishMessageActions: String,CaseIterable{
        case creating = "Tạo lời chúc"
    }
    
    
    let sceneCoordinator: SceneCoordinatorType
    let sampleWishes = PublishRelay<[String]>()
    
    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
    }
    
    func onDismiss() {
        _ = self.sceneCoordinator.pop(animated: true)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return WishPromtType.allCases.count
    }
    
    func getWishSamples() -> Single<[String]>{
        let temp = ["Lời chúc tết năm nay sức khoẻ tràn đầy", "Năm mới phát tài, như ý cát tường","Lời chúc tết năm nay sức khoẻ tràn đầy", "Năm mới phát tài, như ý cát tường"]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            return Single.create { single in
                single(.success(temp))
                return Disposables.create()
            }
        }
        
    }
}
