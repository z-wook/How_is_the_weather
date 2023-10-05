
import UIKit
import SnapKit

//    var view = UIView()
//    weatherview.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
//    var shadows = UIView()
//    shadows.frame = weatherView.frame
//    shadows.clipsToBounds = false
//    self.view.addSubview(shadows)

class WeatherView : UIViewController {

    
    private let viewModel = WeatherViewModel()
    var temperature = UILabel()
    var city = UILabel()
    
    let clothesStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    let sunImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    
    deinit {
        print("WeatherView deinitialize!!!")
    }
            
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
    }
}



//MARK: - WeatherViewModelDelegate
extension WeatherView: WeatherViewModelDelegate {
    func didFetchWeather(weather: Weather) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            if let weatherID = self.viewModel.weatherID {
//                print(weatherID)
//                let bgColor = BackgroundColor(weatherID: weatherID)
//                
//                print(bgColor)
//                let gradientView = AnimatedGradientView(frame: self.view.bounds)
//                gradientView.setGradient(startColor: bgColor.startColor, endColor: UIColor.white)
//                self.view.insertSubview(gradientView, at: 0)
//                print("배경화면 에러?")

                let clothesImage = ClothesImage(weatherID: weatherID)
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

//GradientView 밖으로 빼기
