//
//  WeatherClothes.swift
//  How_is_the_weather
//
//  Created by t2023-m0070 on 10/3/23.
//

import UIKit


class WeatherClothes {
    
    private var weatherType: WeatherType?
    
    init(weatherID: Int) {
        self.weatherType = WeatherType(weatherID: weatherID)
    }
    
    var images: [UIImage] {
        switch weatherType {
        case .thunderstorm:
            return loadImages(named: ["raincoat", "t-shirt", "long-sleeves", "skinny", "denim"])
        case .drizzle:
            return loadImages(named: ["raincoat", "t-shirt", "long-sleeves", "skinny", "denim"])
        case .none:
            return []
        case .some(.rain):
            return loadImages(named: ["raincoat", "t-shirt", "long-sleeves", "denim", "pants"])
        case .some(.snow):
            return loadImages(named: ["jacket", "turtleneck", "long-sleeves", "hoody", "denim", "skinny" ])
        case .some(.atmosphere):
            return []
        case .some(.tornado):
            return loadImages(named: ["jacket", "windbreaker", "hoody", "long-sleeves", "skinny", "denim"])
        case .some(.clear):
            return loadImages(named: ["t-shirt", "long-sleeves", "denim", "pants"])
        case .some(.clouds):
            return loadImages(named: ["t-shirt", "long-sleeves", "denim", "pants"])
        }
    }
    
    private func loadImages(named names: [String]) -> [UIImage] {
        var result: [UIImage] = []
        
        for name in names {
            if let image = UIImage(named: name) {
                result.append(image)
            }
        }
        return result
    }
}

