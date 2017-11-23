//
//  ViewController.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit
import GoogleMaps

class ViewController: UIViewController, GMSMapViewDelegate {

    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var clusteringRadiusTF: UITextField!

    @IBOutlet weak var marpViewBackground: UIView!
    var mapView: ZEClusterMapView?
    
    var testDataArray = [(lat: CLLocationDegrees, lng: CLLocationDegrees)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initTestData()
        createMap()
        createMarkers()
    }

    func initTestData() {
        guard let path = Bundle.main.url(forResource: "demoMarkers", withExtension: "json"), let data = try? Data(contentsOf: path) else {return}
        guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }
        jsonDict?.forEach({ if let lat = $0["latitude"] as? CLLocationDegrees, let lng = $0["longitude"] as? CLLocationDegrees { testDataArray.append((lat, lng)) } })
    }

    func createMap() {
        mapView = ZEClusterMapView(frame: self.marpViewBackground.frame, renderer: ZETestRenderer())
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
    
        if let mapView = mapView {
            self.marpViewBackground.addSubview(mapView)
        }
    }
    
    func createMarkers() {
        testDataArray.forEach({ GMSMarker(position: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng)).map = self.mapView })
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        self.mapView?.add(marker: marker, with: "common")
    }
    
    @IBAction func clusterButtonTapped(_ sender: Any) {
        mapView?.cluster()
    }
    @IBAction func clearButtonTapped(_ sender: Any) {
        mapView?.clear()
    }

}

class ZETestRenderer: NSObject, ZEClusterRendererProtocol {
    
}
