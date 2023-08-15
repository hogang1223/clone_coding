//
//  TitleTextFieldCellViewModel.swift
//  UsedGoodsupload
//
//  Created by hogang on 2023/08/13.
//

import Foundation
import RxCocoa
import RxSwift

struct TitleTextFieldCellViewModel {
    let titleText = PublishRelay<String?>()
}
