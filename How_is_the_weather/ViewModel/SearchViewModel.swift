//
//  SearchViewModel.swift
//  How_is_the_weather
//
//  Copyright (c) 2023 z-wook. All right reserved.
//

import Foundation

final class SearchViewModel {
    var manager = WeatherViewModel()
    private let weatherKey = "weather"
    var weatherList: [WeatherInfo?] = []
    var textFieldText: String? = ""
    var reloadCollectionView: (() -> Void)?
}

extension SearchViewModel {
    var loadWeatherList: Void {
        let cityList = fetchWeather
        
        for city in cityList {
            weatherList.append(WeatherInfo(city: city))
            manager.fetchWeatherForCity(city)
        }
    }
    
    var searchWeather: Void {
        guard let text = textFieldText else { return }
        manager.fetchWeatherForCity(text)
    }
    
    func receiveWeather(weather: Weather) {
        if let index = getIndex(city: weather.name) {
            weatherList[index]?.description = weather.description
            weatherList[index]?.temperature = weather.temperature
            reloadCollectionView?()
            return
        }
        let city = weather.name
        if checkDuplication(city: city) == false {
            let info = WeatherInfo(city: city, description: weather.description, temperature: weather.temperature)
            weatherList.append(info)
            reloadCollectionView?()
            
            let cityList = weatherList.compactMap { weather in
                weather?.city
            }
            saveWeather(list: cityList)
        }
    }
}

private extension SearchViewModel {
    func saveWeather(list: [String]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(list) {
            UserDefaultsManager.setValue(value: encodedData, key: weatherKey)
        }
    }
    
    var fetchWeather: [String] {
        let decoder = JSONDecoder()
        guard let data: Data = UserDefaultsManager.getValue(key: weatherKey),
              let decodedData = try? decoder.decode([String].self, from: data) else { return [] }
        return decodedData
    }
    
    func getIndex(city: String) -> Int? {
        return fetchWeather.firstIndex(of: city)
    }
    
    func checkDuplication(city: String) -> Bool {
        return weatherList.contains {
            $0?.city == city
        }
    }
}
