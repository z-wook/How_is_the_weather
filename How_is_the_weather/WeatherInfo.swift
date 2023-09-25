
import Foundation
import SwiftyJSON


class WeatherInfo {
    
    
    //MARK: - Fetch Weather for city with Update
    private func fetchWeatherForCity(_ city: String) {
        ApiManager.shared.getWeather(forCity: city) { [weak self] result in
            guard let strongSelf = self else { return }
            
            switch result {
            case .success(let json):
                strongSelf.updateUIWithWeatherInfo(json)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func updateUIWithWeatherInfo(_ json: JSON) {
        let weatherDescription = json["weather"][0]["description"].stringValue
        DispatchQueue.main.async {
            self.temperatureLabel.text = weatherDescription
        }
    }

    
    //MARK: - Get Temperature
    private func getTemperature() {
        ApiManager.shared.getTemperature(forCity: "Seoul") { result in
            switch result {
            case .success(let temperature):
                self.temperatureLabel.text = "\(temperature)°C"
            case .failure(let error):
                print("Failed to fetch temperature: \(error.localizedDescription)")
            }
        }
    }
}
