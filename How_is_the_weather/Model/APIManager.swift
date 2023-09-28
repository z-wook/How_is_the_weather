import Alamofire
import Foundation
import SwiftyJSON

// MARK: - Protocols

protocol NetworkService {
    func request(_ url: URL, parameters: [String: Any], completion: @escaping (Result<JSON, AFError>) -> Void)
}

protocol WeatherService {
    func fetchWeather(forCity city: String, completion: @escaping (Result<Weather, WeatherError>) -> Void)
    func fetchWeather(forLatitude latitude: Double, longitude: Double, completion: @escaping (Result<Weather, WeatherError>) -> Void)
}

// MARK: - Networking

struct DefaultNetworkService: NetworkService {
    func request(_ url: URL, parameters: [String: Any], completion: @escaping (Result<JSON, AFError>) -> Void) {
        AF.request(url, parameters: parameters).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(.success(JSON(value)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - API Manager

struct APIManager: WeatherService {
    private let networkService: NetworkService
    private let baseUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather")!
    private let apiKey = Store().API_KEY

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    // 도시이름을 통해 날씨가져오기
    func fetchWeather(forCity city: String, completion: @escaping (Result<Weather, WeatherError>) -> Void) {
        let parameters: [String: Any] = [
            "q": city,
            "appid": apiKey,
            "units": "metric"
        ]
        requestWeather(with: parameters, completion: completion)
    }

    // 좌표를 통해 날씨 가져오기
    func fetchWeather(forLatitude latitude: Double, longitude: Double, completion: @escaping (Result<Weather, WeatherError>) -> Void) {
        let parameters: [String: Any] = [
            "lat": latitude,
            "lon": longitude,
            "appid": apiKey,
            "units": "metric"
        ]
        requestWeather(with: parameters, completion: completion)
    }
    
    // 날씨가져오기 응답처리
    private func requestWeather(with parameters: [String: Any], completion: @escaping (Result<Weather, WeatherError>) -> Void) {
        networkService.request(baseUrl, parameters: parameters) { response in
            switch response {
            case .success(let json):
                if let weather = Weather(json: json) {
                    completion(.success(weather))
                } else {
                    completion(.failure(.parsingError))
                }
            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }
}

// MARK: - Models

struct Weather {
    let description: String
    let temperature: Double

    init?(json: JSON) {
        guard let description = json["weather"][0]["description"].string,
              let temperature = json["main"]["temp"].double else {
            return nil
        }
   
        self.description = description
        self.temperature = temperature
    }
}

enum WeatherError: Error {
    case networkError
    case parsingError
}
