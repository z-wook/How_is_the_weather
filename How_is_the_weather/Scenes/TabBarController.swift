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
    private let homeVC = HomeViewController()
    private let globalVC = GlobalViewController()
    
    private lazy var homeBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "홈디테일",
            style: .plain,
            target: self,
            action: #selector(moveHomeDetailVC)
        )
        return button
    }()
    
    private lazy var globalBarButtonItem: UIBarButtonItem = {
        let button = UIBarButtonItem(
            title: "글로벌디테일",
            style: .plain,
            target: self,
            action: #selector(moveGlobalDetailVC)
        )
        return button
    }()
    
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
        navigationItem.rightBarButtonItem = homeBarButtonItem
        viewControllers = [homeVC, globalVC]
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
        navigationItem.rightBarButtonItem = homeBarButtonItem
        changeTintColor(buttonType: tabBarView.sunBtn)
    }
    
    @objc func didTappedMyPage() {
        selectedIndex = 1
        navigationItem.title = "글로벌"
        navigationItem.rightBarButtonItem = globalBarButtonItem
        changeTintColor(buttonType: tabBarView.globalBtn)
    }
    
    @objc func moveHomeDetailVC() {
        let vc = HomeDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func moveGlobalDetailVC() {
        let vc = GlobalDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
