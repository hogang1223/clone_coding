//
//  MTMapViewError.swift
//  FindCVS
//
//  Created by hogang on 2023/08/14.
//

import Foundation

enum MTMapViewError: Error {
case faildUpdatingCurrentLocation
    case locationAuthorizationDenied
    
    var errorDescription: String {
        switch self {
        case .faildUpdatingCurrentLocation:
            return "현재 위치를 불러오지 못했어요. 잠시 후 다시 시도해주세요."
        case .locationAuthorizationDenied:
            return "위치 정보를 비활성화하면 사용자의 현재 위치를 알 수 없어요."
        }
    }
}
