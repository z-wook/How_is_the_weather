import Alamofire
import Foundation
import SwiftyJSON


class WeatherAPI {
    
    func fetchWeather(forCity city: String, completion: @escaping (String?, Error?) -> Void) {
        let endpoint = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=\(Store().API_KEY)"
        
        AF.request(endpoint).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                let weather = json["weather"].array?.first?["description"].string
                completion(weather, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
