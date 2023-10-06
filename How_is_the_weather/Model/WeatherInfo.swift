//
//  WeatherInfo.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

//
//  WeatherInfo.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation
import UIKit

struct WeatherInfo: Codable {
    var id: Int? = nil
    let city: String?
    var description: String? = nil
    var temperature: Double? = nil
}


enum WeatherType {
    case thunderstorm
    case drizzle
    case rain
    case snow
    case atmosphere //Mist, Smoke, Haze etc
    case tornado
    case clear
    case clouds
    
    init?(weatherID: Int) {
        switch weatherID {
        case 200...232:
            self = .thunderstorm
        case 300...321, 500...531:
            self = .drizzle
        case 600...622:
            self = .snow
        case 701...771:
            self = .atmosphere
        case 781:
            self = .tornado
        case 800:
            self = .clear
        case 801...804:
            self = .clouds
        default:
            return nil
        }
    }
    
    var getIcon: UIImage? {
        switch self {
        case .thunderstorm:
            return UIImage(named: "bolt")
        case .drizzle:
            return UIImage(named: "rain")
        case .rain:
            return UIImage(named: "rain")
        case .snow:
            return UIImage(named: "snow")
        case .atmosphere:
            return UIImage(named: "smoke")
        case .tornado:
            return UIImage(named: "tornado")
        case .clear:
            return UIImage(named: "sun")
        case .clouds:
            return UIImage(named: "cloud")
        }
    }
}


enum TemperatureTypes {
    case coldTemp
    case littleColdTemp
    case littleHotTemp
    case hotTemp
        
    init?(temperature: Int) {
        switch temperature {
        case 0...10:
            self = .coldTemp
        case 11...20:
            self = .littleColdTemp
        case 21...25:
            self = .littleHotTemp
        case 26...40:
            self = .hotTemp
        default:
            return nil
        }
    }
}
