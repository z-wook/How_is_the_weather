//
import Foundation

protocol WeatherViewModelDelegate: AnyObject {
    func didFetchWeather(weather: Weather)
    func didFailToFetchWeather(error: Error)
}

class WeatherViewModel {
    
    weak var delegate: WeatherViewModelDelegate?
    
    private let apiManager: APIManager
    private var weatherData: Weather?
    private let temperatureManager = TemperatureManager()
    var type: TemperatureType = .celsius
    
    var temperatureText: String {
        guard let temperature = weatherData?.temperature else { return "0 °C" }
        return "\(Int(round(temperature))) °C"
    }
    
    var cityName: String {
        return weatherData?.name ?? ""
    }
    
    var weatherID: Int? {
        return weatherData?.id
    }

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }
    
    func fetchWeatherForCity(_ city: String) {
        apiManager.fetchWeather(forCity: city) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let weather):
                self.weatherData = weather
                self.delegate?.didFetchWeather(weather: weather)
            case .failure(let error):
                self.delegate?.didFailToFetchWeather(error: error)
            }
        }
    }
    

    func fetchWeatherForLocation(_ latitude: Double, _ longitude: Double) {
        apiManager.fetchWeather(forLatitude: latitude, longitude: longitude) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case.success(let weather):
                self.weatherData = weather
                self.delegate?.didFetchWeather(weather: weather)
            case.failure(let error):
                self.delegate?.didFailToFetchWeather(error: error)
            }
        }
    }
    var changeUnit: String {
        switch type {
        case .celsius:
            let temperature = temperatureManager.fahrenheitToCelsius(fahrenheit: weatherData?.temperature)
            weatherData?.temperature = temperature
            return "\(Int(round(temperature))) °C"
            
        case .fahrenheit:
            let temperature = temperatureManager.celsiusToFahrenheit(celsius: weatherData?.temperature)
            weatherData?.temperature = temperature
            return "\(Int(round(temperature))) °F"
        }
    }
}
