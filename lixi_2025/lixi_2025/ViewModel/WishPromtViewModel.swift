//
//  WishPromtViewModel.swift
//  lixi_2025
//
//  Created by Le Viet Anh on 30/11/24.
//

import UIKit
import RxSwift
import RxRelay
protocol WishPromtVMProtocol: AnyObject{
    func onDismiss()
    func numberOfRowsInSection(_ section: Int) -> Int
    var sampleWishes: Observable<[String]> {get}
    var creationButtonTapped: PublishSubject<Void> {get set}
    var isGeneratingWishes: Observable<Bool> {get}
    func getSampleWishes()
}
class WishPromtViewModel: WishPromtVMProtocol{
    
    
    
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
        
        var index: Int{
            switch self {
            case .ideaDisplay:
                return 0
            case .recipient:
                return 1
            case .wishMessage:
                return 2
            case .aiSuggestion:
                return 3
            case .literaryTypes(_):
                return 4
            case .actions(_):
                return 5
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
    
    private let disposeBag = DisposeBag()
    var creationButtonTapped: PublishSubject<Void> = PublishSubject()
    
    let sceneCoordinator: SceneCoordinatorType
    private var sampleWishesRelay = PublishRelay<[String]>()
    private var isCreatingWishesRelay = PublishRelay<Bool>()
    
    var isGeneratingWishes: Observable<Bool>{
        return isCreatingWishesRelay.asObservable()
    }
    
    var sampleWishes: Observable<[String]>{
        return sampleWishesRelay.asObservable()
    }

    init(sceneCoordinator: SceneCoordinatorType) {
        self.sceneCoordinator = sceneCoordinator
        
        creationButtonTapped.subscribe(onNext: { [weak self] _ in
            self?.fetchingWishes()
        }).disposed(by: disposeBag)
    }
    
    func onDismiss() {
        _ = self.sceneCoordinator.pop(animated: true)
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return WishPromtType.allCases.count
    }
    
    func getSampleWishes(){
        APIService.shared.getWishSamples().asObservable().subscribe(onNext: { [weak self] samples in
            self?.sampleWishesRelay.accept(samples)
        }).disposed(by: disposeBag)
    }
    
    func fetchingWishes(){
        self.isCreatingWishesRelay.accept(true)
        APIService.shared.generateWish().asObservable().subscribe(onNext: { [weak self] wishes in
//            self?.generatedWishes.accept(samples)
            self?.isCreatingWishesRelay.accept(false)
        }).disposed(by: disposeBag)
    }
    
    
}
