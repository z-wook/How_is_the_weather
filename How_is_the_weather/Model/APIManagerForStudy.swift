import Alamofire
import SwiftyJSON


class APIManagerForStudy {

    static let shared = APIManager()

    private let apiKey = Store().API_KEY

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

//MARK: - API 테스트 로그
struct TestFunctionForStudy {
    func testAPI() {
        APIManagerForStudy.shared.fetchWeather(forCity: "Seoul") { result in
            switch result {
            case .success(let weather):
                print("Successfully fetched weather for Seoul: \(weather.description), \(weather.temperature)°C")
            case .failure(let error):
                print("Failed to fetch weather for Seoul: \(error.localizedDescription)")
            }
        }
    }

}
