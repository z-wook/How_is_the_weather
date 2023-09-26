import XCTest
import Alamofire
@testable import How_is_the_weather


struct MockNetworkService: NetworkService {
    var mockData: Any?
    var mockError: AFError?
    
    func request(_ url: String, parameters: [String: Any], completion: @escaping (Result<Any, AFError>) -> Void) {
        if let data = mockData {
            completion(.success(data))
        } else if let error = mockError {
            completion(.failure(error))
        }
    }
}


class APIManagerTests: XCTestCase {
    
    var apiManager: APIManager!
    var mockService: MockNetworkService!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkService()
        apiManager = APIManager(networkService: mockService)
    }
    
    func testFetchWeatherSuccess() {
        // Mock a successful response
        let mockJSON: [String: Any] = [
            "weather": [["description": "clear sky"]],
            "main": ["temp": 25.0]
        ]
        mockService.mockData = mockJSON
        
        let expectation = self.expectation(description: "Fetch Weather Success")
        
        apiManager.fetchWeather(forCity: "Seoul") { result in
            switch result {
            case .success(let weather):
                XCTAssertEqual(weather.description, "Clear sky")
                XCTAssertEqual(weather.temperature, 25.0)
            case .failure:
                XCTFail("Expected success, but test failed.")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchWeatherFailure() {
        // Mock a failure response
        let error = AFError.invalidURL(url: "invalid")
        mockService.mockError = error
        
        let expectation = self.expectation(description: "Fetch Weather Failure")
        
        apiManager.fetchWeather(forCity: "Seoul") { result in
            switch result {
            case .success:
                XCTFail("Expected failure, but test succeeded.")
            case .failure(let receivedError):
                XCTAssertEqual(receivedError.localizedDescription, error.localizedDescription)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
