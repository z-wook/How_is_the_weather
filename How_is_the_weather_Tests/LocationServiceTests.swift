



import XCTest
@testable import How_is_the_weather

class LocationServiceTests: XCTestCase {
    
    var locationService: LocationService!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        locationService = nil
        super.tearDown()
    }
    
    func testFetchCurrentCoordinates() {
        
        //Given
        let mockLocationService = MockLocationService(location: nil, error: nil)
        locationService = mockLocationService
        let expectation = self.expectation(description: "Fetch Current coordinates")
        
        
        //When
        locationService.fetchCurrentCoordinates { result in
            switch result {
            case .success(let coordinates):
                XCTFail("Expected failure, got coordinates: \(coordinates)")
            case .failure(_):
                break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        
        
    }
}
