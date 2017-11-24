//
//  ZEClusterMarker.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit
import GoogleMaps

class ZEClusterMarker: GMSMarker {

    private(set) var markers = [GMSMarker]()
    
    // MARK: - collection Methods
    
    func add(marker: GMSMarker) {
        if !markers.contains(marker) {
            if let marker = marker as? ZEClusterMarker {
                self.add(markers: marker.markers)
            } else {
                markers.append(marker)
            }
        }
    }
    
    func add(markers: [GMSMarker]) {
        markers.forEach {self.add(marker: $0)}
    }
    
    func remove(marker: GMSMarker) {
        if let marker = marker as? ZEClusterMarker {
            self.remove(markers: marker.markers)
        } else {
            markers = markers.filter({$0 != marker})
        }
    }
    
    func remove(markers: [GMSMarker]) {
        markers.forEach({ self.remove(marker: $0)})
    }
    
    // MARK: -
    
    func dispose() {
        markers.removeAll()
    }
    
    func calculatePosition() -> CLLocationCoordinate2D {
        var sumLat: CLLocationDegrees = 0
        var sumLng: CLLocationDegrees = 0
        
        if markers.isEmpty == true {return CLLocationCoordinate2D(latitude: 0, longitude: 0)}
        
        markers.forEach {
            sumLat += $0.position.latitude
            sumLng += $0.position.longitude
        }
        return CLLocationCoordinate2DMake(sumLat/Double(markers.count), sumLng/Double(markers.count))
    }
}
