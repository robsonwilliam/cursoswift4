//
//  ViewController.swift
//  GMapkit
//
//  Created by Gustavo Lima on 24/04/2018.
//  Copyright © 2018 Instituto Eldorado. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        let overlayPath = "https://mt.google.com/vt/lyrs=r&x={x}&y={y}&z={z}"
        
        let overlay = MKTileOverlay(urlTemplate: overlayPath)
        
        overlay.canReplaceMapContent = true
        
        self.mapView.add(overlay)
    }


    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        guard let tileOverlay = overlay as? MKTileOverlay else {
            return MKOverlayRenderer(overlay: overlay)
        }
        return MKTileOverlayRenderer(tileOverlay: tileOverlay)
    }


}

