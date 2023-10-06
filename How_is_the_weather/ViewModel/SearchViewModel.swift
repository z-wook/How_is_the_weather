
import Foundation

final class SearchViewModel {
    let weatherManager = WeatherViewModel()
    let temperatureManager = TemperatureManager()
    private let weatherKey = "weather"
    var weatherList: [WeatherInfo?] = []
    var textFieldText: String? = ""
    var type: TemperatureType = .celsius
    var reloadCollectionView: (() -> Void)?
}

extension SearchViewModel {
    var loadWeatherList: Void {
        weatherList.removeAll()
        reloadCollectionView?()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            let cityList = fetchCityList
            for city in cityList {
                weatherList.append(WeatherInfo(city: city))
                weatherManager.fetchWeatherForCity(city)
            }
        }
    }
    
    var searchWeather: Void {
        guard let text = textFieldText else { return }
        weatherManager.fetchWeatherForCity(text)
    }
    
    func receiveWeather(weather: Weather) {
        if let index = getIndex(city: weather.name) {
            weatherList[index]?.id = weather.id
            weatherList[index]?.description = weather.description
            weatherList[index]?.temperature = weather.temperature
            reloadCollectionView?()
            return
        }
        let city = weather.name
        if checkDuplication(city: city) == false {
            let info = WeatherInfo(id: weather.id, city: city, description: weather.description, temperature: weather.temperature)
            weatherList.append(info)
            reloadCollectionView?()
            
            let cityList = weatherList.compactMap { weather in
                weather?.city
            }
            saveCityList(list: cityList)
        }
    }
    
    func removeWeather(index: IndexPath) {
        weatherList.remove(at: index.item)
        reloadCollectionView?()
        
        var list = fetchCityList
        list.remove(at: index.item)
        saveCityList(list: list)
    }
    
    var changeUnit: Void {
        switch type {
        case .celsius:
            let updateList = weatherList.map { info in
                var updatedInfo = info
                updatedInfo?.temperature = temperatureManager.fahrenheitToCelsius(fahrenheit: info?.temperature)
                return updatedInfo
            }
            weatherList = updateList
        case .fahrenheit:
            let updateList = weatherList.map { info in
                var updatedInfo = info
                updatedInfo?.temperature = temperatureManager.celsiusToFahrenheit(celsius: info?.temperature)
                return updatedInfo
            }
            weatherList = updateList
        }
        reloadCollectionView?()
    }
}

private extension SearchViewModel {
    func saveCityList(list: [String]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(list) {
            UserDefaultsManager.setValue(value: encodedData, key: weatherKey)
        }
    }
    
    var fetchCityList: [String] {
        let decoder = JSONDecoder()
        guard let data: Data = UserDefaultsManager.getValue(key: weatherKey),
              let decodedData = try? decoder.decode([String].self, from: data) else { return [] }
        return decodedData
    }
    
    func getIndex(city: String) -> Int? {
        return fetchCityList.firstIndex(of: city)
    }
    
    func checkDuplication(city: String) -> Bool {
        return weatherList.contains {
            $0?.city == city
        }
    }
}

