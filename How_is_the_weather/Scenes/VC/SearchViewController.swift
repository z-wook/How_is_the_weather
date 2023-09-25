//
//  SearchViewController.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

final class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
    
    deinit {
        print("deinit - GlobalVC")
    }
}
