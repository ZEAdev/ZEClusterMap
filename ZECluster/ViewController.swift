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
        
        CLLocationManager().requestWhenInUseAuthorization()
        
        initTestData()
        createMap()
        createMarkers()
    }

    func initTestData() {
        guard let path = Bundle.main.url(forResource: "demoMarkers", withExtension: "json"), let data = try? Data(contentsOf: path) else {return}
        guard let jsonDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] else { return }
        jsonDict?.forEach({
            guard let latStr = $0["latitude"] as? String, let lngStr = $0["longitude"] as? String else {return}
            if let lat = CLLocationDegrees(latStr), let lng = CLLocationDegrees(lngStr) { testDataArray.append((lat, lng))}
        })
    }

    func createMap() {
        mapView = ZEClusterMapView(frame: self.marpViewBackground.frame, renderer: ZETestRenderer())
        mapView?.delegate = self
        mapView?.isMyLocationEnabled = true
        mapView?.settings.myLocationButton = true
        mapView?.clusterOnlyVisible = true
        
        if let mapView = mapView {
            self.marpViewBackground.addSubview(mapView)
        }
    }
    
    func createMarkers() {
        testDataArray.forEach({ mapView?.add(marker: GMSMarker(position: CLLocationCoordinate2D(latitude: $0.lat, longitude: $0.lng)), with: "common")})
    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        self.mapView?.add(marker: marker, with: "common")
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let date = Date()
        self.mapView?.cluster()
        print("\(date.timeIntervalSinceNow)")
    }
    
    @IBAction func clusterButtonTapped(_ sender: Any) {
        mapView?.cluster()
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        mapView?.clear()
    }
}

class ZETestRenderer: NSObject, ZEClusterRendererProtocol {
    
    func icon(count: Int, tag: String?) -> UIImage {
        guard let image = UIImage(named: "clusteredMarker") else {return UIImage()}
        let imageView = UIImageView(image: image)
        let countLabel = UILabel(frame: imageView.frame)
        countLabel.text = "\(count)"
        countLabel.font = UIFont.systemFont(ofSize: 13)
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        imageView.addSubview(countLabel)
        
        UIGraphicsBeginImageContextWithOptions(image.size, false, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else {return UIImage()}
        imageView.layer.render(in: context)
        guard let icon = UIGraphicsGetImageFromCurrentImageContext() else {return UIImage()}
        UIGraphicsEndImageContext()
        return icon
    }
    
}
