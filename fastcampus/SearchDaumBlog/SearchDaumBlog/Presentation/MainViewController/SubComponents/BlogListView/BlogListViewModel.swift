//
//  BlogListViewModel.swift
//  SearchDaumBlog
//
//  Created by hogang on 2023/08/11.
//

import Foundation
import RxCocoa
import RxSwift

struct BlogListViewModel {
    let filterViewModel = FilterViewModel()
    
    let blogCellData = PublishSubject<[BlogListCellData]>()
    let cellData: Driver<[BlogListCellData]>
    
    init() {
        self.cellData = blogCellData
            .asDriver(onErrorJustReturn: [])
    }
}
