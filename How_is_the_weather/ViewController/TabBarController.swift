//
//  TabBarController.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {
    private let gpsManager = GPSManager()
    private let viewModel = WeatherViewModel()
    private let tabBarView = TabBarView()
    private let weatherVC = WeatherView()
    private let searchVC = SearchViewController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.delegate = self
        gpsManager.setLocationManager()
        setUpGPSManagerClosure()
        
        
        configure()
        setLayout()
        configTabBarBtn()
    }
    
}

private extension TabBarController {
    func configure() {
        tabBar.isHidden = true
        navigationItem.title = "날씨어때"
        viewControllers = [weatherVC, searchVC]
        
    }
    
    func setLayout() {
        view.addSubview(tabBarView)
        
        tabBarView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.width.equalTo(280)
            $0.height.equalTo(65)
        }
        
        
    }
    
    func configTabBarBtn() {
        tabBarView.sunBtn.addTarget(self, action: #selector(didTappedHome), for: .touchUpInside)
        tabBarView.globalBtn.addTarget(self, action: #selector(didTappedMyPage), for: .touchUpInside)
    }
    
    func changeTintColor(buttonType: UIButton) {
        tabBarView.sunBtn.tintColor = (buttonType == tabBarView.sunBtn) ? .systemRed : .systemGray
        tabBarView.globalBtn.tintColor = (buttonType == tabBarView.globalBtn) ? .systemRed : .systemGray
    }
    
    @objc func didTappedHome() {
        selectedIndex = 0
        navigationItem.title = "날씨"
        changeTintColor(buttonType: tabBarView.sunBtn)
    }
    
    @objc func didTappedMyPage() {
        selectedIndex = 1
        navigationItem.title = "검색"
        changeTintColor(buttonType: tabBarView.globalBtn)
    }
}


extension TabBarController {
    func setBackground(forWeatherID weatherID: Int) {
        let bgColor = BackgroundColor(weatherID: weatherID)
        let gradientView = AnimatedGradientView(frame: self.view.bounds)
        gradientView.setGradient(startColor: bgColor.startColor, endColor: UIColor.white)
        self.view.insertSubview(gradientView, at: 0)
    }
    
}

extension TabBarController: WeatherViewModelDelegate {
    func didFetchWeather(weather: Weather) {
        if let weatherID = viewModel.weatherID {
            setBackground(forWeatherID: weatherID)
        }
    }
    
    func didFailToFetchWeather(error: Error) {
        print("Failed to fetch weather: \(error.localizedDescription)")
    }
}


extension TabBarController {
    private func setUpGPSManagerClosure() {
        gpsManager.didUpdateLocation = { [weak self] latitude, longitude in
            print("TabbarVC Closure called with latitude: \(latitude), longitude: \(longitude)")
            
            self?.gpsManager.getCityName(latitude: latitude, longitude: longitude) { cityName in
                guard let cityName = cityName else { return }
                
                print("TabbarVC Closure called with cityName: \(cityName)")
                self?.viewModel.fetchWeatherForCity(cityName)
            }
        }
    }
}
