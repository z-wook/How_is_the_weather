//
//  GPS.swift
//  How_is_the_weather
//
//  Created by Junyoung_Hong on 2023/09/27.
//

import Foundation
import CoreLocation

class GPSManager: NSObject, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()
    
    // GPS setting
    func setLocationManager() {
        
        locationManager.delegate = self
        
        //위치추적권한요청 when in foreground
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        //베터리에 맞게 권장되는 최적의 정확도
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            print(lat)
            print(lon)
        }
    }
        
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
}
