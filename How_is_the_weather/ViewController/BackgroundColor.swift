import UIKit



struct BackgroundColor {
    
    private static let thunderstormColor = UIColor.darkGray
    private static let drizzleColor = UIColor.lightGray
    private static let rainColor = UIColor.blue
    private static let snowColor = UIColor.white
    private static let atmosphereColor = UIColor(white: 0.8, alpha: 1.0)
    private static let tornadoColor = UIColor.red
    private static let clearColor = UIColor.yellow
    private static let cloudsColor = UIColor.gray
    
    private var startColor: UIColor
    
    var gradientLayer: CAGradientLayer {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        return gradient
    }
    
    init(weatherID: Int) {
        let weatherType = WeatherType(weatherID: weatherID)
        
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
    }
}
