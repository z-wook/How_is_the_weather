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
    
    var temperatureText: String {
        return "\(weatherData?.temperature ?? 0)°C"
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
}
