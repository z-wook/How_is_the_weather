import XCTest
import Alamofire
import SwiftyJSON
@testable import How_is_the_weather

class WeatherAPITests: XCTestCase {
    
    var api: WeatherAPI!
    
    override func setUp() {
        super.setUp()
        api = WeatherAPI()
    }
    
    func testRealFetchWeatherForSeoul() {
        let expectation = self.expectation(description: "Fetching weather data for Seoul")
        
        api.fetchWeather(forCity: "Seoul") { weather, error in
            XCTAssertNotNil(weather, "Weather data for Seoul should not be nil")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let error = error {
                XCTFail("waitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
}
