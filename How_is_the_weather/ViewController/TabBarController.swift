//
//  TabBarController.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class TabBarController: UITabBarController {
    
    private let tabBarView = TabBarView()
    private let weatherVC = WeatherView()
    private let searchVC = SearchViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setLayout()
        configTabBarBtn()
    }
}

private extension TabBarController {
    func configure() {
        tabBar.isHidden = true
        navigationItem.title = "날씨어때"
        view.backgroundColor = .systemBackground
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
