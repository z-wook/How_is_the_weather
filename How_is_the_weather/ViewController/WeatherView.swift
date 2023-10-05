
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
    
    let clothesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    var city = UILabel()
    
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
    
    //MARK - Clothes 이미지뷰
    lazy var clothesView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clothesView")
        imageView.frame = CGRect(x: 0, y: 0, width: 350, height: 250)
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
        temperature.backgroundColor = .none
        temperature.frame = CGRect(x: 400, y: 400, width: 300, height: 300)
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
        locationButton.addTarget(self, action: #selector(refreshLocation), for: .touchUpInside)
    }
    @objc func refreshLocation(){
        
        didGetGPS(latitude: gpsManager.lat, longitude: gpsManager.lon)
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
        view.addSubview(clothesView)
        view.addSubview(clothesStackView)
        
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
        clothesView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-200)
            make.height.equalTo(100)
        }
        
        
        clothesStackView.snp.makeConstraints {
            $0.left.equalTo(clothesView.snp.left).offset(30)
            $0.top.equalTo(clothesView.snp.top).offset(10)
        }
    }
}

//MARK: - WeatherViewModelDelegate
extension WeatherView: WeatherViewModelDelegate {
    func didFetchWeather(weather: Weather) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let weatherID = self.viewModel.weatherID {
                
                let clothesImage = WeatherClothes(weatherID: weatherID)
                for image in clothesImage.images {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    self.clothesStackView.addArrangedSubview(imageView)
                }
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
