import CoreLocation
@testable import How_is_the_weather


struct MockLocationService: LocationService {
    func fetchCurrentLocation(completion: @escaping (Result<CLLocationCoordinate2D, LocationError>) -> Void) {
        let mockLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
        completion(.success(mockLocation))
    }
    
}
