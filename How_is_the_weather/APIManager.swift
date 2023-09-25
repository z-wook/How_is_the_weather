import Alamofire
import SwiftyJSON

class ApiManager {

    static let shared = ApiManager()
    private let apiKey = Storage().apiKey
    private let baseUrl = "https://api.openweathermap.org/data/2.5/weather"

    private init() {}

    func getWeather(forCity city: String, completion: @escaping (Result<JSON, AFError>) -> Void) {
        let parameters: [String: Any] = [
            "q": city,
            "appid": apiKey
        ]

        AF.request(baseUrl, parameters: parameters).responseJSON { response in
            switch response.result {
            case .success(let value):
                completion(.success(JSON(value)))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
