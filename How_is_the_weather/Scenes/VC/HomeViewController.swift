//
//  HomeViewController.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit
import SnapKit

final class HomeViewController: UIViewController {
    let weatherView = WeatherView()
    
    override func loadView() {
        super.loadView()
        view = weatherView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
    }
    
    deinit {

        print("deinit - HomeVC")
    }
}
