import UIKit



struct BackgroundColor {
    
    
    private static let thunderstormColor = UIColor(hex: "#5E8A3B")
    private static let drizzleColor = UIColor(hex: "#83919E")
    private static let rainColor = UIColor(hex: "#83919E")
    private static let snowColor = UIColor(hex: "#5797F6")
    private static let atmosphereColor = UIColor(hex: "#F9A67E")
    private static let tornadoColor = UIColor(hex: "#0F1E23")
    private static let clearColor = UIColor(hex: "#5FC9FC")
    private static let cloudsColor = UIColor(hex: "#5FC9FC")

    
    private(set) var startColor: UIColor
    
    var gradientLayer: CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }
    
    init(weatherID: Int) {
        let weatherType = WeatherType(weatherID: weatherID)
        print("weatherType:::: \(weatherID)")
        switch weatherType {
        case .thunderstorm:
            startColor = BackgroundColor.thunderstormColor
        case .drizzle:
            startColor = BackgroundColor.drizzleColor
        case .rain:
            startColor = BackgroundColor.rainColor
        case .snow:
            startColor = BackgroundColor.snowColor
        case .atmosphere:
            startColor = BackgroundColor.atmosphereColor
        case .tornado:
            startColor = BackgroundColor.tornadoColor
        case .clear:
            startColor = BackgroundColor.clearColor
        case .clouds:
            startColor = BackgroundColor.cloudsColor
        case .none:
            startColor = UIColor.black
        }
        print(startColor)
    }
}
