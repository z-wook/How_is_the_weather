import UIKit


//MARK: - Properties & deinit
class ViewController: UIViewController {
    
    @IBOutlet weak var temperatureLabel: UILabel!
    private let viewModel = ViewControllerModel()
    
    deinit {
        print("ViewController deinitialize!!")
    }
}

//MARK: - Life Cycle
extension ViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchWeatherForCity("Seoul")
    }
        
}


//MARK: - Weather Display Protocol-Delegate
extension ViewController: ViewControllerModelDelegate {
    func didFetchWeather(weather: Weather) {
        temperatureLabel.text = "\(weather.description), \(weather.temperature)°C"
    }

    func didFailToFetchWeather(error: Error) {
        print("Failed to fetch weather: \(error.localizedDescription)")
    }
}
