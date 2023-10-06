
import UIKit
import SnapKit
import CoreLocation

class WeatherView : UIViewController {
    
    private let gpsManager = GPSManager()
    private let apiManager = APIManager()
    private let temperatureManager = TemperatureManager()
    private let viewModel = WeatherViewModel()
    
    var temperature = UIButton(type: .system)
    var locationButton = UIButton()
    
    private lazy var clothesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .clear
        stack.spacing = 20
        stack.layoutMargins = UIEdgeInsets(top: 75, left: 25, bottom: 75, right: 25)
        stack.isLayoutMarginsRelativeArrangement = true
        
        // 그림자 효과
        stack.layer.shadowColor = UIColor.black.cgColor
        stack.layer.shadowOffset = CGSize(width: 0, height: 2)
        stack.layer.shadowOpacity = 0.3
        stack.layer.shadowRadius = 5
        
        // 블러 효과
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = stack.bounds
        blurredEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurredEffectView.layer.cornerRadius = 30
        blurredEffectView.clipsToBounds = true
        stack.insertSubview(blurredEffectView, at: 0)
        return stack
    }()

    
    
    var city = UILabel()
    
    let sunImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.layer.shadowOffset = CGSize(width: 2, height: 2)
        imageView.layer.shadowRadius = 2
        imageView.layer.shadowOpacity = 0.5
        imageView.contentMode = .scaleAspectFit
            return imageView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        gpsManager.delegate = self
        
        setlayout()
        makeTemperature()
        makeCity()
        makeLocationButton()
        gpsManager.setLocationManager()
    }
    
    func makeTemperature() {
        let text = NSMutableAttributedString.customTemperatureText(inputText: "10 °C")
        temperature.setAttributedTitle(text, for: .normal)
        temperature.titleLabel?.font = .systemFont(ofSize: 100)
        temperature.setTitleColor(UIColor.white, for: .normal)
        temperature.frame = CGRect(x: 400, y: 400, width: 300, height: 300)
        temperature.titleLabel?.layer.shadowColor = UIColor.black.cgColor
        temperature.titleLabel?.layer.shadowOffset = CGSize(width: 2, height: 2)
        temperature.titleLabel?.layer.shadowRadius = 2
        temperature.titleLabel?.layer.shadowOpacity = 0.5
        temperature.addTarget(self, action: #selector(changeUnit), for: .touchUpInside)
    }
    
    @objc private func changeUnit(_ sender: UIButton) {
        viewModel.type = viewModel.type == .celsius ? .fahrenheit : .celsius
        let text = NSMutableAttributedString.customTemperatureText(inputText: viewModel.changeUnit)
        sender.setAttributedTitle(text, for: .normal)
    }
    
    func makeLocationButton() {
        locationButton.setImage(UIImage(systemName: "location.circle.fill"), for: .normal)
        locationButton.tintColor = UIColor.black
        locationButton.layer.shadowColor = UIColor.black.cgColor
        locationButton.layer.shadowOffset = CGSize(width: 2, height: 2)
        locationButton.layer.shadowRadius = 2
        locationButton.layer.shadowOpacity = 0.5
        locationButton.addTarget(self, action: #selector(refreshLocation), for: .touchUpInside)
    }
    
    @objc func refreshLocation(){
        didGetGPS(latitude: gpsManager.lat, longitude: gpsManager.lon)
    }
    
    func makeCity() {
        city.textColor = .white
        city.font = .systemFont(ofSize: 18)
        city.layer.shadowOffset = CGSize(width: 2, height: 2)
        city.layer.shadowRadius = 2
        city.layer.shadowOpacity = 0.5
    }
    
    func setlayout() {
        view.addSubview(temperature)
        view.addSubview(city)
        view.addSubview(sunImageView)
        view.addSubview(locationButton)
        view.addSubview(clothesStackView)
        
        temperature.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.centerX.equalToSuperview()
        }
        city.snp.makeConstraints { make in
            make.top.equalTo(temperature.snp.bottom)
            make.leading.equalTo(temperature).offset(40)
        }
        sunImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(city.snp.bottom).offset(15)
            make.width.height.equalTo(120)
        }
        locationButton.snp.makeConstraints { make in
            make.centerY.equalTo(city)
            make.leading.equalTo(city.snp.trailing).offset(20)
        }
        clothesStackView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(sunImageView.snp.bottom).offset(30)
        }
    }
}

//MARK: - WeatherViewModelDelegate
extension WeatherView: WeatherViewModelDelegate {
    func didFetchWeather(weather: Weather) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            let temperature = Int(weather.temperature)
            let clothesImages = WeatherClothes(temperature: temperature)
          clothesStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }

            for image in clothesImages.images {
                let imageView = UIImageView(image: image)
                imageView.contentMode = .scaleAspectFit
                self.clothesStackView.addArrangedSubview(imageView)
            }
            
            let text = NSMutableAttributedString.customTemperatureText(inputText: viewModel.temperatureText)
            self.temperature.setAttributedTitle(text, for: .normal)
            self.city.text = self.viewModel.cityName
            sunImageView.image = WeatherType(weatherID: weather.id)?.getIcon
        }
    }

    func didFailToFetchWeather(error: Error) {
        print("Failed to fetch weather: \(error.localizedDescription)")
    }
}


//MARK: - GPSManager Delegate
extension WeatherView: GPSManagerDelegate {
    func didGetGPS(latitude: Double, longitude: Double) {
        print("WeatherView Delegate method called with latitude: \(latitude), longitude: \(longitude)")
        
        gpsManager.getCityName(latitude: latitude, longitude: longitude) { [weak self] cityName in
            guard let self = self, let cityName = cityName else { return }
            print("WeatherView Delegate method called with CitiName:\(cityName)")
            
            self.viewModel.fetchWeatherForCity(cityName)
        }
    }
}
