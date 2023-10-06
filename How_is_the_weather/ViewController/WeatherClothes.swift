//
//  WeatherClothes.swift
//  How_is_the_weather
//
//  Created by t2023-m0070 on 10/3/23.
//

import UIKit
class WeatherClothes {
    
    private var temperatureType: TemperatureTypes?
    
    init(temperature: Int) {
        self.temperatureType = TemperatureTypes(temperature: temperature)
    }
    
    var images: [UIImage] {
        switch temperatureType {
        case .coldTemp:
            return loadImages(named: ["jacket", "turtleneck", "skinny", "anorak"])
        case .littleColdTemp:
            return loadImages(named: ["skinny", "hoody", "long-sleeves", "windbreaker"])
        case .littleHotTemp:
            return loadImages(named: ["long-sleeves", "pants", "t-shirt", "windbreaker"])
        case .hotTemp:
            return loadImages(named: ["t-shirt", "dennim", "pants", "windbreaker"])
        case .none:
            return []
        }
    }
    
    private func loadImages(named names: [String]) -> [UIImage] {
        var result: [UIImage] = []
        
        for name in names {
            if let image = UIImage(named: name) {
                result.append(image)
            } else {
                print("Failed to load image named: \(name)")
            }
        }
        return result
    }

}

