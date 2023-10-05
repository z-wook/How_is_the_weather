
import UIKit
import SnapKit
import CoreLocation

//    var view = UIView()
//    weatherview.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
//    var shadows = UIView()
//    shadows.frame = weatherView.frame
//    shadows.clipsToBounds = false
//    self.view.addSubview(shadows)

class WeatherView : UIViewController {

    let gpsController = GPSManager()
    let apiManager = APIManager()
    let temperatureManager = TemperatureManager()
    
    var temperature = UIButton(type: .system)
    var locationButton = UIButton()
    
    private let viewModel = WeatherViewModel()

    var city = UILabel()
    let thunderstormImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "thunderstorm")
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()
    let drizzleImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "drizzle")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    let rainImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "rain")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    let snowImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "snow")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    let atmosphereImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "atmosphere")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    let tornadoImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tornado")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    let sunImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        return imageView
    }()

    let cloudsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cloud")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.fetchWeatherForCity("london")
        
        setlayout()
        makeTemperature()
        makeCity()
        makeLocationButton()
        gpsController.setLocationManager()
    }
    
    func makeTemperature() {
//        temperature.setTitle("10", for: .normal)
        temperature.titleLabel?.font = .systemFont(ofSize: 100)
        temperature.setTitleColor(UIColor.white, for: .normal)
        temperature.backgroundColor = .none
    }
    
    func makeLocationButton() {
        locationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = UIColor.black
        locationButton.addTarget(self, action: #selector(refreshLocation), for: .touchUpInside)
    }
    @objc func refreshLocation(){
        
        didGetGPS(latitude: gpsController.lat, longitude: gpsController.lon)
//        gpsController.setLocationManager()
//        viewModel.fetchWeatherForLocation(gpsController.lat, gpsController.lon)
//        apiManager.fetchWeather(forLatitude: gpsController.lat, longitude: gpsController.lon) { result in
//            switch result {
//            case.success(let weather):
//                self.temperature.setTitle(String(weather.temperature), for: .normal)
//                self.city.text = String(weather.name)
//            case.failure(let error):
//                print(error)
//            }
//        }
    }
    
    func makeCity() {
        city.textColor = .black
        city.font = .systemFont(ofSize: 20)
    }
    func setlayout() {
        view.addSubview(temperature)
        view.addSubview(city)
        view.addSubview(sunImageView)
        view.addSubview(locationButton)
        
        temperature.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.left.equalToSuperview().offset(10)
        }
        city.snp.makeConstraints { make in
            make.top.equalTo(temperature.snp.bottom)
            make.centerX.equalTo(temperature)
        }
        sunImageView.snp.makeConstraints { make in
            make.centerY.equalTo(temperature.snp.centerY)
            make.left.equalTo(temperature.snp.right).offset(20)
            make.right.equalToSuperview().offset(-30)
        }
        locationButton.snp.makeConstraints { make in
            make.centerY.equalTo(city)
            make.centerX.equalTo(sunImageView)
        }
    }
}


//MARK: - WeatherViewModelDelegate

extension WeatherView: WeatherViewModelDelegate {
    
    func didFetchWeather(weather: Weather) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let weatherID = self.viewModel.weatherID {
                print(weatherID)
                
                if let weatherIcon = WeatherIcons.getWeatherIcon(result: weatherID) {
                    self.sunImageView.image = weatherIcon
                }
                let bgColor = BackgroundColor(weatherID: weatherID).gradientLayer
                bgColor.frame = self.view.bounds
                self.view.layer.insertSublayer(bgColor, at: 0)
            }

            self.temperature.setTitle(self.viewModel.temperatureText, for: .normal)
            self.temperature.titleLabel?.font = UIFont.systemFont(ofSize: 80)
            self.city.text = self.viewModel.cityName
        }
    }
    
    func didFailToFetchWeather(error: Error) {
        print("Failed to fetch weather: \(error.localizedDescription)")
    }
}

extension WeatherView: GPSManagerDelegate {
    func didGetGPS(latitude: Double, longitude: Double) {
        gpsController.setLocationManager()
        viewModel.fetchWeatherForLocation(latitude, longitude)
    }
}

