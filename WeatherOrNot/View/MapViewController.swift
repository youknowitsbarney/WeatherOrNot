//
//  MapViewController.swift
//  WeatherOrNot
//
//  Created by Barney on 13/01/2021.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    var delegate: MapViewDelegate?
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupTapGestureRecognizer()
    }
    
    // MARK: Setup Tap Gesture Recognizer
    private func setupTapGestureRecognizer() {
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(locationTapped(sender:)))
        mapView.addGestureRecognizer(tap)
    }
    
    @objc private func locationTapped(sender: UITapGestureRecognizer) {
        
        let point = sender.location(in: self.mapView)
        let location = mapView.convert(point, toCoordinateFrom: mapView)
        
        let pin = MKPointAnnotation()
        pin.coordinate = location
        mapView.addAnnotation(pin)
        
        DispatchQueue.main.async {
            
            let selectedLocation = CLLocation(latitude: location.latitude, longitude: location.longitude)
            self.delegate?.locationSelected(location: selectedLocation)
            self.navigationController?.popViewController(animated: true)
        }
    }
}

// MARK: Extensions
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? { return nil }
}

// MARK: Map View Protocol
protocol MapViewDelegate: class {
    
        func locationSelected(location: CLLocation)
    }
