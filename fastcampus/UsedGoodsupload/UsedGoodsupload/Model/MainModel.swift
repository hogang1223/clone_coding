//
//  MainModel.swift
//  UsedGoodsupload
//
//  Created by hogang on 2023/08/13.
//

import Foundation

struct MainModel {
    func setAlert(errorMessage: [String]) -> Alert {
        let title = errorMessage.isEmpty ? "성공" : "실패"
        let message = errorMessage.isEmpty ? nil : errorMessage.joined(separator: "\n")
        return (title: title, message: message)
    }
}
 
