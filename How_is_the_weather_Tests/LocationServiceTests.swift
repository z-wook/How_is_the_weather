

import XCTest
@testable import How_is_the_weather
import CoreLocation

class LocationServiceTests: XCTest {
    func testFetchCurrentLocationSuccess() {
        let mockService = MockLocationService()
        var fetchedLocation: CLLocationCoordinate2D?
        var fetchedError: Error?
        
        mockService.fetchCurrentLocation { result in
            switch result {
            case .success(let location):
                fetchedLocation = location
            case .failure(let error):
                fetchedError = error
            }
        }
        
        XCTAssertNotNil(fetchedLocation)
        XCTAssertNil(fetchedError)
    }
    

}
