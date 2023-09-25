import Alamofire
import SwiftyJSON

class APIManager {
    static let shared = APIManager()

    private let apiKey = ""

    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"

    private init() {}

    func fetchWeather(forCity city: String, completion: @escaping (Result<Weather, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "q": city,
            "appid": apiKey,
            "units": "metric"
        ]

        AF.request(baseUrl, parameters: parameters).validate().responseJSON { response in
            switch response.result {
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

struct TestFunction {
    
    func testAPI() {
        APIManager.shared.fetchWeather(forCity: "Seoul") { result in
            switch result {
            case .success(let weather):
                print("Successfully fetched weather for Seoul: \(weather.description), \(weather.temperature)°C")
            case .failure(let error):
                print("Failed to fetch weather for Seoul: \(error.localizedDescription)")
            }
        }
    }

}
