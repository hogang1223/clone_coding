//
//  DetailListBackgroudViewModel.swift
//  FindCVS
//
//  Created by hogang on 2023/08/14.
//

import Foundation
import RxCocoa
import RxSwift

struct DetailListBackgroudViewModel {
    let isStatusLabelHidden: Signal<Bool>
    let shouldHideStatusLabel = PublishSubject<Bool>()
    
    init() {
        isStatusLabelHidden = shouldHideStatusLabel
            .asSignal(onErrorJustReturn: true)
    }
}
