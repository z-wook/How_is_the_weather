
// SearchViewModelTests.swift
import XCTest
@testable import How_is_the_weather


class MockWeatherViewModel: WeatherViewModel {
    var isFetchWeatherForCityCalled = false
    var fetchedCity: String?
    
    override func fetchWeatherForCity(_ city: String) {
        isFetchWeatherForCityCalled = true
        fetchedCity = city
    }
}


class SearchViewModelTests: XCTestCase {
    var sut: SearchViewModel!
    var mockWeatherManager: MockWeatherViewModel!
    
    override func setUp() {
        super.setUp()
        mockWeatherManager = MockWeatherViewModel()
        sut = SearchViewModel()
        sut.manager = mockWeatherManager
    }
    
    override func tearDown() {
        sut = nil
        mockWeatherManager = nil
        super.tearDown()
    }
    
    func testSearchWeather() {
        // Given
        sut.textFieldText = "Seoul"
        
        // When
        _ = sut.searchWeather
        
        // Then
        XCTAssertTrue(mockWeatherManager.isFetchWeatherForCityCalled)
        XCTAssertEqual(mockWeatherManager.fetchedCity, "Seoul")
    }
}
