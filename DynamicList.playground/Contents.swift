import SwiftUI
import PlaygroundSupport
import MapKit

struct Location: Hashable {
    var latitude: Double
    var longitude: Double
}

struct MyView: View {
    
    var locations = [Location]()
    
    init() {
        locations.append(Location(latitude: 49.232882, longitude: 6.995835)) // Saarbrücken
        locations.append(Location(latitude: 48.137281, longitude: 11.575690)) // München
        locations.append(Location(latitude: 52.519604, longitude: 13.410921)) // Berlin
        
        // generate 10 more
        for _ in 1...10 {
            let latitude = Double.random(in: -90...90)
            let longitude = Double.random(in: -180...180)
            locations.append(Location(latitude: latitude, longitude: longitude))
        }
    }
    
    var body: some View {
        NavigationView {
            List(locations.identified(by: \.self)) { location in
                NavigationButton(destination: DetailView(selectedLocation: location), isDetail: true) {
                    Text("\(location.latitude), \(location.longitude)")
                }
            }.navigationBarTitle(Text("Storm Viewer"))
        }
    }
}

struct DetailView: View {
    var selectedLocation: Location
    
    var body: some View {
        MapView(centerCoordinate: CLLocationCoordinate2D(latitude: selectedLocation.latitude, longitude: selectedLocation.longitude))
    }
}

struct MapView: UIViewRepresentable {
    
    var centerCoordinate: CLLocationCoordinate2D
    
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = centerCoordinate
        let span = MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

struct MapView_Preview: PreviewProvider {
    static var previews: some View {
        MapView(centerCoordinate: CLLocationCoordinate2D(latitude: 49.232882, longitude: 6.995835))
    }
}

let viewController = UIHostingController(rootView: MyView())
PlaygroundPage.current.liveView = viewController
