//
//  LocationInformationViewModelTests.swift
//  FindCVSTests
//
//  Created by hogang on 2023/08/17.
//

import XCTest
import Nimble
import RxSwift
import RxTest

@testable import FindCVS

class LocationInformationViewModelTests: XCTestCase {
    let disposeBag = DisposeBag()
    
    let stubNetwork = LocalNetworkStub()
    var model: LocationInformationModel!
    var viewModel: LocationInformationViewModel!
    var doc: [KLDocument]!
    
    override func setUp() {
        self.model = LocationInformationModel(localNetwork: stubNetwork)
        self.viewModel = LocationInformationViewModel(model: model)
        self.doc = cvsList
    }
    
    func testSetMapCenter() {
        let scheduler = TestScheduler(initialClock: 0)
        
        let dummyDataEvent = scheduler.createHotObservable([.next(0, cvsList)])
        let documentData = PublishSubject<[KLDocument]>()
        
        dummyDataEvent
            .subscribe(documentData)
            .disposed(by: disposeBag)
        
        let itemSelectedEvent = scheduler.createHotObservable([.next(1, 0)])
        let itemSelected = PublishSubject<Int>()
        itemSelectedEvent
            .subscribe(itemSelected)
            .disposed(by: disposeBag)
        
        let selectedItemMapPoint = itemSelected
            .withLatestFrom(documentData) { $1[0] }
            .map(model.documentTOMTMapPoint)
        
        let initialMapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: Double(37.394225), longitude: Double(127.110341)))!
        let currentLocationEvent = scheduler.createHotObservable([
            .next(0, initialMapPoint)
        ])
        
        let initialCurrentLocation = PublishSubject<MTMapPoint>()
        
        currentLocationEvent
            .subscribe(initialCurrentLocation)
            .disposed(by: disposeBag)
        
        //현재 위치 버튼 탭 이벤트
        let currentLocationButtonTapEvent = scheduler.createHotObservable([
            .next(2, Void()),
            .next(3, Void())
        ])
        
        let currentLocationButtonTapped = PublishSubject<Void>()
        
        currentLocationButtonTapEvent
            .subscribe(currentLocationButtonTapped)
            .disposed(by: disposeBag)
        
        let moveToCurrentLocation = currentLocationButtonTapped
            .withLatestFrom(initialCurrentLocation)
        
        let currentMapCenter = Observable
            .merge(
                selectedItemMapPoint,
                initialCurrentLocation.take(1),
                moveToCurrentLocation
            )
        
        let currentMapCenterObserver = scheduler.createObserver(Double.self)
        
        currentMapCenter
            .map { $0.mapPointGeo().latitude }
            .subscribe(currentMapCenterObserver)
            .disposed(by: disposeBag)
        
        scheduler.start()
        
        let secondMapPoint = model.documentToMTMapPoint(doc[0])
        
        expect(currentMapCenterObserver.events).to(
            equal([
                .next(0, initialMapPoint.mapPointGeo().latitude),
                .next(1, secondMapPoint.mapPointGeo().latitude),
                .next(2, initialMapPoint.mapPointGeo().latitude),
                .next(3, initialMapPoint.mapPointGeo().latitude)
            ])
        )
    }
}
