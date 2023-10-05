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
        gradientLayer.startPoint = CGPoint(x: 0.55, y: 0.25)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
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
        locationsAnimation.duration = 8.0
        locationsAnimation.fromValue = [0.0, 0.5]
        locationsAnimation.toValue = [0.5, 1.0]
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
    
    convenience init(hex: String) {
        let hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner = Scanner(string: hexSanitized)
        
        if hexSanitized.hasPrefix("#") {
            scanner.currentIndex = scanner.string.index(after: scanner.currentIndex)
        }
        
        var hexNumber: UInt64 = 0
        
        if scanner.scanHexInt64(&hexNumber) {
            let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
            let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
            let blue = CGFloat(hexNumber & 0x0000FF) / 255
            self.init(red: red, green: green, blue: blue, alpha: 1.0)
        } else {
            self.init(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
