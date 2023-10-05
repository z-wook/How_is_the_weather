
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
        viewModel.fetchWeatherForCity("Seoul")
        
        setlayout()
        makeTemperature()
        makeCity()
        makeLocationButton()
        gpsController.setLocationManager()
    }
    
    
    func makeTemperature() {
        temperature.setTitle("10 °C", for: .normal)
        temperature.titleLabel?.font = .systemFont(ofSize: 100)
        temperature.setTitleColor(UIColor.white, for: .normal)
        temperature.backgroundColor = .none
        temperature.frame = CGRect(x: 400, y: 400, width: 300, height: 300)
        temperature.addTarget(self, action: #selector(changeUnit), for: .touchUpInside)
    }
    func makeLocationButton() {
        locationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = UIColor.black
        locationButton.addTarget(self, action: #selector(RefreshLocation), for: .touchUpInside)
    }
    @objc func RefreshLocation(){
        
        gpsController.setLocationManager()
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
            make.centerX.equalToSuperview()
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
                let bgColor = BackgroundColor(weatherID: weatherID).gradientLayer
                bgColor.frame = self.view.bounds
                self.view.layer.insertSublayer(bgColor, at: 0)
            }
//            self.temperature.titleLabel?.text = self.viewModel.temperatureText
            self.temperature.titleLabel?.font = UIFont.systemFont(ofSize: 80)
            self.city.text = self.viewModel.cityName
            temperature.setTitle(viewModel.temperatureText, for: .normal)
        }
    }
    
    func didFailToFetchWeather(error: Error) {
        print("Failed to fetch weather: \(error.localizedDescription)")
    }
    
    @objc private func changeUnit(_ sender: UIButton) {
        viewModel.type = viewModel.type == .celsius ? .fahrenheit : .celsius
        sender.setTitle(viewModel.changeUnit, for: .normal)
    }
}
