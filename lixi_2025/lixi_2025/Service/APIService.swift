//
//  APIService.swift
//  lixi_2025
//
//  Created by Build ios on 2/12/24.
//

import UIKit
import RxSwift
import RxRelay
class APIService{
    static let shared = APIService()
    
    func getWishSamples() -> Single<[String]> {
        let temp = ["Lời chúc tết năm nay sức khoẻ tràn đầy", "Năm mới phát tài, như ý cát tường", "Lời chúc tết năm nay sức khoẻ tràn đầy", "Năm mới phát tài, như ý cát tường"]
        return Single.create { single in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                single(.success(temp))
            }
            return Disposables.create()
        }
    }
    
    func generateWish() -> Single<[String]> {
        let temp = ["Năm cũ qua đi, năm mới đã tới. Chúc bạn bầu trời sức khỏe, biển cả tình thương, đại dương tình bạn, sự nghiệp sáng ngời, gia đình thịnh vượng.", "Năm mới chúc bạn thực hiện được những dự định còn dang dở, quen thêm những người bạn mới, đến những vùng đất mới.", "Lời chúc tết năm nay sức khoẻ tràn đầy", "Năm hết Tết đến, rước lộc vào nhà, quà cáp bao la, mọi nhà no đủ, vàng bạc đầy tủ, gia chủ phát tài, già trẻ gái trai sum vầy hạnh phúc."]
        return Single.create { single in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                single(.success(temp))
            }
            return Disposables.create()
        }
    }
}
