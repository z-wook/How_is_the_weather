//
//  TemperatureManager.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class TemperatureManager {
    func celsiusToFahrenheit(celsius: Double?) -> Double {
        guard let celsius = celsius else { return 0 }
        let fahrenheit = (celsius * 9/5) + 32
        return fahrenheit
    }
    
    func fahrenheitToCelsius(fahrenheit: Double?) -> Double {
        guard let fahrenheit = fahrenheit else { return 0 }
        let celsius = (fahrenheit - 32) * 5/9
        return celsius
    }
}
