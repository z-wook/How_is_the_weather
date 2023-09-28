



import Foundation
import CoreLocation


protocol LocationService {
    func fetchCurrentLocation(completion: @escaping(Result<CLLocationCoordinate2D, LocationError>) -> Void)
}

enum LocationError: Error {
    case locationError
    case permissionDenied
}
