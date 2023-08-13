//
//  PriceTextFieldCellViewModel.swift
//  UsedGoodsupload
//
//  Created by hogang on 2023/08/13.
//

import Foundation
import RxCocoa
import RxSwift

struct PriceTextFieldCellViewModel {
    let showFreeShareButton: Signal<Bool>
    let resetPrice: Signal<Void>
    
    let priceValue = PublishRelay<String?>()
    let freeShareButtonTapped = PublishRelay<Void>()
    
    init() {
        self.showFreeShareButton = Observable
            .merge(
                priceValue.map { $0 ?? "" == "0" },
                freeShareButtonTapped.map { _ in false }
            )
            .asSignal(onErrorJustReturn: false)
        
        self.resetPrice = freeShareButtonTapped
            .asSignal(onErrorSignalWith: .empty())
    }
}
