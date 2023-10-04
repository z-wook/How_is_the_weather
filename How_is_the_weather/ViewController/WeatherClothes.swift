
import UIKit


class ClothesImage {
    
    private var weatherType: WeatherType?
    
    init(weatherID: Int) {
        self.weatherType = WeatherType(weatherID: weatherID)
    }
    
    var images: [UIImage] {
        switch weatherType {
        case .thunderstorm:
            return loadImages(named: ["thunderstormClothes1", "thunderstormClothes2"])
        case .drizzle:
            return loadImages(named: ["drizzleClothes1", "drizzleClothes2"])
        case .none:
            return []
        case .some(.rain):
            return []

        case .some(.snow):
            return []

        case .some(.atmosphere):
            return []

        case .some(.tornado):
            return []

        case .some(.clear):
            return []

        case .some(.clouds):
            return []

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
