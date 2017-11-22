//
//  ZEClusterProtocols.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit
import GoogleMaps

typealias markerTuple = (marker: GMSMarker, tag: String?)
typealias clusteredMarkerLists = (markers: [GMSMarker], tag: String?)

protocol ZEClusterRendererProtocol: NSObjectProtocol {
    
}

protocol ZEClusterAlgorimtProtocol: NSObjectProtocol {
    func cluster(markers: [markerTuple]) -> [clusteredMarkerLists]
}

extension GMSMarker {
    func distanceTo(marker: GMSMarker!) -> CLLocationDistance{
        let myLocation = CLLocation(latitude: self.position.latitude, longitude: self.position.longitude)
        let markerLocation  = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        
        return myLocation.distance(from: markerLocation)
    }
    
    func middlePositionToMarker(marker: GMSMarker!) -> CLLocationCoordinate2D {
        
    }
}
