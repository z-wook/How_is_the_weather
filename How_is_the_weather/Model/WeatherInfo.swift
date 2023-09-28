//
//  WeatherInfo.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

struct WeatherInfo: Codable {
    let city: String?
    var description: String? = nil
    var temperature: Double? = nil
}
