

import CoreLocation

struct MockLocationService: LocationService {
    var location: CLLocationCoordinate2D?
    var error: LocationError?
    
    func fetchCurrentCoordinates(completion: @escaping (Result<CLLocationCoordinate2D, LocationError>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let location = location {
            completion(.success(location))
        }
    }
}
