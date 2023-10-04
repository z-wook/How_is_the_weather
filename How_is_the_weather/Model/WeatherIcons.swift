//
//  WeatherIcons.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import UIKit

struct WeatherIcons {
    static func getWeatherIcon(result: Int?) -> UIImage? {
        guard let result = result else { return nil }
        if 200...232 ~= result { // Thunderstorm
            return UIImage(named: "bolt")
        } else if 300...321 ~= result || 500...531 ~= result { // Drizzle, Rain
            return UIImage(named: "rain")
        } else if 600...622 ~= result { // Snow
            return UIImage(named: "snow")
        } else if 701...771 ~= result { // Mist, Smoke, Haze, Dust, Fog, Sand, Ash, Squall
            return UIImage(named: "smoke")
        } else if 781 == result { // Tornado
            return UIImage(named: "tornado")
        } else if 800 == result { // Clear
            return UIImage(named: "sun")
        } else { // Clouds
            return UIImage(named: "cloud")
        }
    }
}
