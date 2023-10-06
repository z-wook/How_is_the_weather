//
//  GPS.swift
//  How_is_the_weather
//
//  Created by Junyoung_Hong on 2023/09/27.
//

import Foundation
import CoreLocation

protocol GPSManagerDelegate: AnyObject {
    func didGetGPS(latitude: Double, longitude: Double)
}

class GPSManager: NSObject, CLLocationManagerDelegate {
    var didUpdateLocation: ((Double, Double) -> Void)?
    
    weak var delegate: GPSManagerDelegate?
    
    var locationManager = CLLocationManager()
    var lat: CLLocationDegrees = .zero
    var lon: CLLocationDegrees = .zero
    
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
            lat = location.coordinate.latitude
            lon = location.coordinate.longitude
            print(lat)
            print(lon)
            delegate?.didGetGPS(latitude: lat, longitude: lon)
            didUpdateLocation?(lat, lon)
            
        }
    }
    
    // 위치 가져오기 실패
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error")
    }
    
    
    
    // 좌표에 따른 도시명 가져오기
    func getCityName(latitude: Double, longitude: Double, completion: @escaping (String?) -> Void) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        let geocoder = CLGeocoder()
        
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first, error == nil {
                completion(placemark.locality) // returns city name
            } else {
                completion(nil)
            }
        }
    }
    
}
