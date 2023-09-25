
import Foundation

protocol ViewControllerModelDelegate: AnyObject {
    func didFetchWeather(weather: Weather)
    func didFailToFetchWeather(error: Error)
}

class ViewControllerModel {
    
    weak var delegate: ViewControllerModelDelegate?

    func fetchWeatherForCity(_ city: String) {
        ApiManager.shared.fetchWeather(forCity: city) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.delegate?.didFetchWeather(weather: weather)
            case .failure(let error):
                self?.delegate?.didFailToFetchWeather(error: error)
            }
        }
    }
}
