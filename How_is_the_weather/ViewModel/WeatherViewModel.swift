import Foundation

protocol ViewControllerModelDelegate: AnyObject {
    func didFetchWeather(weather: Weather)
    func didFailToFetchWeather(error: Error)
}

class WeatherViewModel {
    
    weak var delegate: ViewControllerModelDelegate?
    
    private let apiManager: APIManager

    init(apiManager: APIManager = APIManager()) {
        self.apiManager = apiManager
    }

    func fetchWeatherForCity(_ city: String) {
        apiManager.fetchWeather(forCity: city) { [weak self] result in
            switch result {
            case .success(let weather):
                self?.delegate?.didFetchWeather(weather: weather)
            case .failure(let error):
                self?.delegate?.didFailToFetchWeather(error: error)
            }
        }
    }
}


//protocol ViewControllerModelDelegate: AnyObject {
//    func didFetchWeather(weather: Weather)
//    func didFailToFetchWeather(error: Error)
//}
//
//class ViewControllerModel {
//    
//    weak var delegate: ViewControllerModelDelegate?
//
//    func fetchWeatherForCity(_ city: String) {
//        APIManager.shared.fetchWeather(forCity: city) { [weak self] result in
//            switch result {
//            case .success(let weather):
//                self?.delegate?.didFetchWeather(weather: weather)
//            case .failure(let error):
//                self?.delegate?.didFailToFetchWeather(error: error)
//            }
//        }
//    }
//}
