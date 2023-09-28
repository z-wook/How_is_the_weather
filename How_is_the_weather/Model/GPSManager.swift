


import CoreLocation

protocol LocationService {
    func fetchCurrentCoordinates(completion: @escaping(Result<CLLocationCoordinate2D, LocationError>) -> Void)
}


enum LocationError: Error {
    case locationUnavailable
}
