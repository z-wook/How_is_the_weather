
import UIKit
import SnapKit

//    var view = UIView()
//    weatherview.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
//    var shadows = UIView()
//    shadows.frame = weatherView.frame
//    shadows.clipsToBounds = false
//    self.view.addSubview(shadows)

class WeatherView : UIViewController {
    
    let clothesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let viewModel = WeatherViewModel()
    var temperature = UILabel()
    var city = UILabel()
    let sunImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
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
        viewModel.fetchWeatherForCity("Seoul")
        
        setlayout()
        makeTemperature()
        makeCity()
    }
    
    func makeTemperature() {
        temperature.textColor = .black
        temperature.font = .systemFont(ofSize: 110)
        temperature.text = "10"
    }
    func makeCity() {
        city.textColor = .black
        city.font = .systemFont(ofSize: 20)
        city.text = "서울특별시"
    }
    func setlayout() {
        view.addSubview(temperature)
        view.addSubview(city)
        view.addSubview(sunImageView)
        view.addSubview(clothesView)
        
        view.addSubview(clothesStackView)
        
        temperature.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(130)
            make.left.equalToSuperview().offset(80)
        }
        city.snp.makeConstraints { make in
            make.top.equalTo(temperature.snp.bottom)
            make.centerX.equalTo(temperature)
        }
        sunImageView.snp.makeConstraints { make in
            make.centerY.equalTo(temperature.snp.centerY)
            make.left.equalTo(temperature.snp.right).offset(20)
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
                let bgColor = BackgroundColor(weatherID: weatherID).gradientLayer
                bgColor.frame = self.view.bounds
                self.view.layer.insertSublayer(bgColor, at: 0)
                
                let clothesImage = WeatherClothes(weatherID: weatherID)
                for image in clothesImage.images {
                    let imageView = UIImageView(image: image)
                    imageView.contentMode = .scaleAspectFit
                    self.clothesStackView.addArrangedSubview(imageView)
                }
            }
        }
    }
    
    func didFailToFetchWeather(error: Error) {
        print("Failed to fetch weather: \(error.localizedDescription)")
    }
}
