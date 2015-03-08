//
//  ViewController.swift
//  locBase
//
//  Created by Rodolfo Castillo on 07/03/15.
//  Copyright (c) 2015 Rodolfo Castillo. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    @IBOutlet weak var daMap: MKMapView!
    
    @IBOutlet weak var daLabel: UILabel!
    
    var manager: CLLocationManager!
    var mlocations: [CLLocation] = []
    
    override func viewDidLoad() {
        //manager = spawnLoc()
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        super.viewDidLoad()
        
        daMap.delegate = self
        daMap.mapType = MKMapType.Standard
        daMap.showsUserLocation = true
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        daLabel.text = "\(locations[0])"
        mlocations.append(locations[0] as CLLocation)
        
        let spanX = 0.007
        let spanY = 0.007
        var newRegion = MKCoordinateRegion(center: daMap.userLocation.coordinate, span: MKCoordinateSpanMake(spanX, spanY))
        daMap.setRegion(newRegion, animated: true)
        
        if (mlocations.count > 1){
            var sourceIndex = mlocations.count - 1
            var destinationIndex = mlocations.count - 2
            
            let c1 = mlocations[sourceIndex].coordinate
            let c2 = mlocations[destinationIndex].coordinate 
            var a = [c1, c2]
            var polyline = MKPolyline(coordinates: &a, count: a.count)
            daMap.addOverlay(polyline)
        }
        
        
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline {
            var polylineRenderer = MKPolylineRenderer(overlay: overlay)
            polylineRenderer.strokeColor = UIColor.blueColor()
            polylineRenderer.lineWidth = 4
            return polylineRenderer
        }
        return nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func spawnLoc(a:CLLocation)->CLLocation{
        let locat = CLLocation(
            latitude: 0.50007773,
            longitude: -0.1246402)
            return locat
        
    }


}

