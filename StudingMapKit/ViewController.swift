//
//  ViewController.swift
//  StudingMapKit
//
//  Created by Paloma Bispo on 10/10/18.
//  Copyright © 2018 Paloma Bispo. All rights reserved.
//

import UIKit
import MapKit


class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        
        userLocation()
        locationManager.delegate = self
    }
    
    
    func showMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees){

        let coodinationCenter = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        let region = MKCoordinateRegion(center: coodinationCenter, span: span)
        
        //set the currenty visible region in map
        mapView.setRegion(region, animated: true)
        
        //add a mark point in the map
        markMapPoint(coordinate: coodinationCenter, title: "IFCE", subTitle: "Academy")
        
    }
    
    func updateMap(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        let coodinationCenter = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coodinationCenter, span: mapView.region.span)
        mapView.setRegion(region, animated: true)
        if let annotation = mapView.annotations.first as? MKPointAnnotation{
            annotation.coordinate = coodinationCenter
        }
        
        
    }
    
    func userLocation(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        guard let userLocation = locationManager.location else {return}
        showMap(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.latitude)
    }
    
    func markMapPoint(coordinate: CLLocationCoordinate2D, title: String, subTitle: String){
        let pointAnnotation = MKPointAnnotation()
        pointAnnotation.coordinate = coordinate
        pointAnnotation.title = title
        pointAnnotation.subtitle = subTitle
        mapView.addAnnotation(pointAnnotation)
    }

}

extension ViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let currentyLocation = locations.last else {return}
        
        let latitude = currentyLocation.coordinate.latitude
        let longitude = currentyLocation.coordinate.longitude
        updateMap(latitude: latitude, longitude: longitude)
    }
}


