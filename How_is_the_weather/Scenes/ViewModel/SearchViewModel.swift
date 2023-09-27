//
//  SearchViewModel.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class SearchViewModel {
    let manager = ViewControllerModel()
    private let weatherKey = "weather"
    var weatherList: [WeatherInfo] = []
    var textFieldText: String? = ""
    var reloadCollectionView: (() -> Void)?
}

extension SearchViewModel {
    var getWeather: Void {
        guard let text = textFieldText else { return }
        manager.fetchWeatherForCity(text)
    }
    
    func saveWeather(weather: Weather) {
        guard let text = textFieldText else { return }
        let info = WeatherInfo(city: text, description: weather.description, temperature: weather.temperature)
        weatherList.append(info)
        reloadCollectionView?()
        
        var list = fetchWeather
        list.append(info)
        
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(list) {
            UserDefaultsManager.setValue(value: encodedData, key: weatherKey)
        }
    }
    
    var loadWeatherList: Void {
        weatherList = fetchWeather
        reloadCollectionView?()
    }
    
    private var fetchWeather: [WeatherInfo] {
        let decoder = JSONDecoder()
        guard let data: Data = UserDefaultsManager.getValue(key: "weather"),
              let decodedData = try? decoder.decode([WeatherInfo].self, from: data) else { return [] }
        return decodedData
    }
}
