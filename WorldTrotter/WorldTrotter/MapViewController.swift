//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by T1aluno10 on 24/04/18.
//  Copyright © 2018 T1aluno10. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    var button: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    var locationManager = CLLocationManager.init()
    var locationNumber = 0
    
    override func loadView() {
        
        // Create a map view
        mapView = MKMapView()
        
        // Set it as *the* view of this view controller
        view = mapView
        
        // - SegmentControl
        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satellite"])
        
        segmentedControl.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self,
                                   action: #selector(MapViewController.mapTypeChanged(_:)),
                                   for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        // - Constraints
        let topConstraint =
            segmentedControl.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor,
                                                  constant: 8)
        let margins = view.layoutMarginsGuide
        let leadingConstraint =
            segmentedControl.leadingAnchor.constraint(equalTo: margins.leadingAnchor)
        let trailingConstraint =
            segmentedControl.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        
        // - Activating constraints
        topConstraint.isActive = true
        leadingConstraint.isActive = true
        trailingConstraint.isActive = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("MapViewController loaded its view.")
        
        locationManager.requestWhenInUseAuthorization()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let NewBornLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        let interestinLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        centerMapOnLocation(location: initialLocation)
        
        let button = UIButton(type: .custom)
        let button2 = UIButton(type: .detailDisclosure)
        let buttonWidth = 40
        
        button.frame = CGRect(x: 15,y: 100,width: buttonWidth, height: buttonWidth)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 0.3 * button.bounds.size.width
        button.layer.borderWidth = 0.75
        button.layer.borderColor = UIColor.darkGray.cgColor
        button.layer.backgroundColor = UIColor.lightGray.cgColor
        button.setTitle("○", for: UIControlState())
        button.setTitleColor(UIColor.darkGray, for: UIControlState())
        button.addTarget(self, action: #selector(MapViewController.setLocation(_:)), for: .touchUpInside)
  
        button2.frame = CGRect(x: 30,y: 160,width: buttonWidth, height: buttonWidth)
        button2.translatesAutoresizingMaskIntoConstraints = false
        button2.layer.cornerRadius = 0.3 * button.bounds.size.width
        button2.layer.borderWidth = 0.75
        button2.layer.backgroundColor = UIColor.green.cgColor
        button2.setTitle("->", for: UIControlState())
        button2.setTitleColor(UIColor.blue, for: UIControlState())
        //button2.addTarget(self, action: #selector(MapViewController.changeLocation()), for: .touchUpInside)

        
        view.addSubview(button)
        
        let safeButtonArea = self.view.safeAreaLayoutGuide
        button.topAnchor.constraint(equalTo: safeButtonArea.topAnchor, constant: 40).isActive = true
        //button.leadingAnchor.constraint(equalTo: safeButtonArea.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: safeButtonArea.trailingAnchor, constant: -10).isActive = true
        //button.heightAnchor.constraint(equalToConstant: 20).isActive = true

        //button2.topAnchor.constraint(equalTo: safeButtonArea.topAnchor, constant: 100).isActive = true
        //button2.trailingAnchor.constraint(equalTo: safeButtonArea.trailingAnchor, constant: -10).isActive = true

        
        let artwork1 = Artwork(title: "111111",
                              locationName: "11111",
                              discipline: "11111",
                              coordinate: CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661))
        mapView.addAnnotation(artwork1)
        
        let artwork2 = Artwork(title: "2222",
                               locationName: "22222",
                               discipline: "22222",
                               coordinate: CLLocationCoordinate2D(latitude: 11.283921, longitude: -17.831661))
        mapView.addAnnotation(artwork2)
        
        let artwork3 = Artwork(title: "33333",
                               locationName: "33333",
                               discipline: "33333",
                               coordinate: CLLocationCoordinate2D(latitude: 1.283921, longitude: -47.831661))
        mapView.addAnnotation(artwork3)

    }
    
    
    let regionRadius: CLLocationDistance = 1000
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius, regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    
    
    // - Functions
    // - @extends objective C - @objc
    @objc func mapTypeChanged(_ segControl: UISegmentedControl) {
        
        switch segControl.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }
    
    @objc func changeLocation() {
        

    }
    
    
    @objc func setLocation(_ sender: UIButton!) {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
        if locationManager.location != nil {
            let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func setLocation2(_ sender: UIButton!) {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
        if locationManager.location != nil {
            let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    @objc func setLocation3(_ sender: UIButton!) {
        let span = MKCoordinateSpan.init(latitudeDelta: 0.0075, longitudeDelta: 0.0075)
        if locationManager.location != nil {
            let region = MKCoordinateRegion.init(center: (locationManager.location?.coordinate)!, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
}

extension MapViewController: MKMapViewDelegate {
    // 1
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // 2
        guard let annotation = annotation as? Artwork else { return nil }
        // 3
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        // 4
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            as? MKMarkerAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            // 5
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        return view
    }
}
