//
//  LocationInformationModelTests.swift
//  FindCVSTests
//
//  Created by hogang on 2023/08/17.
//

import XCTest
import Nimble

@testable import FindCVS

class LocationInformationModelTests: XCTestCase {
    let stubNetwork = LocalNetworkStub()
    
    var doc: [KLDocument]!
    var model: LocationInformationModel!
    
    override func setUp() {
        self.model = LocationInformationModel(localNetwork: stubNetwork)
        self.doc = cvsList
    }
    
    func testDocumentsToCellData() {
        let cellData = model.testDocumentsToCellData(doc) // 실제 모델의 값
        let placeName = doc.map { $0.placeName } // dummy
        let address0 = cellData[1].address // 실제 모델 값
        let roadAddressName = doc[1].roadAddressName // dummy
        
        expect(cellData.map { $0.placeName}).to(
            eqaul(placeName),
            description:"DetailListCellData와 placeName은 document의 PlaceName이다.")
        
        expect(address0).to(
            eqaul(roadAddressName),
            description:"KLDocument의 RoadAddressName이 빈 값이 아닐 경우 roadAddress가 cellData에 전달된다.")
        
    }
}
