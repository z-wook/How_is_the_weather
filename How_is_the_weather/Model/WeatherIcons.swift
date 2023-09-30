//
//  WeatherIcons.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

enum WeatherIcons: String {
    case clear_sky
    case few_clouds
    case scattered_clouds
    case broken_clouds
    case shower_rain
    case rain
    case thunderstorm
    case snow
    case mist
    
    var title: String {
        return rawValue
    }
    
//    var image: UIImage? {
//        switch self {
//        case .clear_sky:
//            return UIImage(named: <#T##String#>)
//        case .few_clouds:
//            return UIImage(named: <#T##String#>)
//        case .scattered_clouds:
//            return UIImage(named: <#T##String#>)
//        case .broken_clouds:
//            return UIImage(named: <#T##String#>)
//        case .shower_rain:
//            return UIImage(named: <#T##String#>)
//        case .rain:
//            return UIImage(named: <#T##String#>)
//        case .thunderstorm:
//            return UIImage(named: <#T##String#>)
//        case .snow:
//            return UIImage(named: <#T##String#>)
//        case .mist:
//            return UIImage(named: <#T##String#>)
//        }
//    }
}
