import UIKit
import SwiftyJSON


//MARK: - Properties & Deinit
class ViewController: UIViewController {
    
    @IBOutlet weak var weatherLabel: UILabel!
    
    deinit {
        print("ViewController deinitialize!!")
    }
}
 
//MARK: - Lifecycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherForCity("Seoul")
    }
}


//MARK: - Fetch Weather with update
extension ViewController {
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
            self.weatherLabel.text = weatherDescription
        }
    }
}
