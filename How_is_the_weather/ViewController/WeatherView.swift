//
//  WeatherView.swift
//  How_is_the_weather
//
//  Created by t2023-m0095 on 2023/09/26.

import UIKit
import SnapKit

//    var view = UIView()
//    weatherview.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
//    var shadows = UIView()
//    shadows.frame = weatherView.frame
//    shadows.clipsToBounds = false
//    self.view.addSubview(shadows)

class WeatherView : UIViewController {
    var temperature = UIButton(type: .system)
    var city = UILabel()
    let thunderstormImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "thunderstorm")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
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
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    let cloudsImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "clouds")
        imageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setlayout()
    
        makeTemperature()
        makeCity()
    }
    
    func makeTemperature() {
        temperature.setTitle("10", for: .normal)
        temperature.titleLabel?.font = .systemFont(ofSize: 100)
        temperature.backgroundColor = .none
        temperature.frame = CGRect(x: 400, y: 400, width: 300, height: 300)
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
            make.left.equalToSuperview().offset(100)
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



