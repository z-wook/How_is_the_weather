import UIKit

public class AnimatedGradientView: UIView {
    
    // MARK: - Properties
    
    private var gradientLayer: CAGradientLayer!
    private var dynamicStartColor: UIColor?
    private var dynamicEndColor: UIColor?
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradientLayer()
    }
    
    // MARK: - Functions
    
    private func setupGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.20)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.75)
        layer.addSublayer(gradientLayer)
    }
    
    func setGradient(startColor: UIColor, endColor: UIColor) {
        dynamicStartColor = startColor
        dynamicEndColor = endColor
        updateColorsForInitialSetup()
        startGradientAnimation()
    }
    
    private func updateColorsForInitialSetup() {
        gradientLayer.colors = [dynamicStartColor!.cgColor, dynamicEndColor!.cgColor]
        gradientLayer.locations = [0, 0]
    }
    
    private func startGradientAnimation() {
        let locationsAnimation = CABasicAnimation(keyPath: "locations")
        locationsAnimation.duration = 5.0
        locationsAnimation.fromValue = [0, 0.45]
        locationsAnimation.toValue = [0.55, 1]
        locationsAnimation.autoreverses = true
        locationsAnimation.repeatCount = Float.infinity
        gradientLayer.add(locationsAnimation, forKey: "locationsChange")
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if let startColor = dynamicStartColor,
            let endColor = dynamicEndColor {
            gradientLayer.colors = [startColor.resolvedColor(with: self.traitCollection).cgColor,
                                    endColor.resolvedColor(with: self.traitCollection).cgColor]
        }
    }
}


public extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")

        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }

    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static func dynamic(light: UIColor, dark: UIColor) -> UIColor {
        return UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return dark
            default:
                return light
            }
        }
    }
}

