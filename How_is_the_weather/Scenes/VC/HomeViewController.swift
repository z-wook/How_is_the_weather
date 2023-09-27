import UIKit
import CoreLocation

final class HomeViewController: UIViewController {
    
    let gpsController = GPSController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        gpsController.setLocationManager()
        print()
    }
    
    deinit {
        print("deinit - HomeVC")
    }
}








