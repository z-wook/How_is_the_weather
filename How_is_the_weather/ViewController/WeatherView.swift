//
//  WeatherView.swift
//  How_is_the_weather
//
//  Created by t2023-m0095 on 2023/09/26.
//

import Foundation
import UIKit
import SnapKit

//    var view = UIView()
//    weatherview.frame = CGRect(x: 0, y: 0, width: 390, height: 844)
//    var shadows = UIView()
//    shadows.frame = weatherView.frame
//    shadows.clipsToBounds = false
//    self.view.addSubview(shadows)

class WeatherView : UIViewController {
    var temperature = UILabel()
    var city = UILabel()
    let sunImageView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sun")
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


