import Alamofire
import SwiftyJSON

protocol NetworkService {
    func request(_ url: String, parameters: [String: Any], completion: @escaping (Result<Any, AFError>) -> Void)
}

struct DefaultNetworkService: NetworkService {
    func request(_ url: String, parameters: [String: Any], completion: @escaping (Result<Any, AFError>) -> Void) {
        AF.request(url, parameters: parameters).validate().responseJSON { response in
            completion(response.result)
        }
    }
}

struct APIManager {
    private let networkService: NetworkService
    
    private let apiKey = Store().API_KEY
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"

    init(networkService: NetworkService = DefaultNetworkService()) {
        self.networkService = networkService
    }

    func fetchWeather(forCity city: String, completion: @escaping (Result<Weather, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "q": city,
            "appid": apiKey,
            "units": "metric"
        ]

        networkService.request(baseUrl, parameters: parameters) { response in
            switch response {
            case .success(let value):
                let json = JSON(value)
                if let weather = Weather(json: json) {
                    completion(.success(weather))
                } else {
                    completion(.failure(AFError.responseValidationFailed(reason: .dataFileNil)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

struct Weather {
    
    let description: String
    let temperature: Double

    init?(json: JSON) {
        guard let description = json["weather"][0]["description"].string,
              let temperature = json["main"]["temp"].double else {
            return nil
        }
        self.description = description.capitalized
        self.temperature = temperature
    }
}


//MARK: - API 테스트 로그
struct TestFunction {
    func testAPI() {
        let apiManager = APIManager()
        apiManager.fetchWeather(forCity: "Seoul") { result in
            switch result {
            case .success(let weather):
                print("Successfully fetched weather for Seoul: \(weather.description), \(weather.temperature)°C")
            case .failure(let error):
                print("Failed to fetch weather for Seoul: \(error.localizedDescription)")
            }
        }
    }
}


