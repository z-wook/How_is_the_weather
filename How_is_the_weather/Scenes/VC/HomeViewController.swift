import UIKit

final class HomeViewController: UIViewController {
    
    var viewModel = ViewControllerModel()
    
    let weatherLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchWeatherForCity("Seoul")
        view.backgroundColor = .systemBackground
    }
    
    deinit {
        print("deinit - HomeVC")
    }
}

extension HomeViewController: ViewControllerModelDelegate {
    func didFetchWeather(weather: Weather) {
        weatherLabel.text = weather.description
    }
    
    func didFailToFetchWeather(error: Error) {
        print("didFailToFetchWeather!!")
    }
}








