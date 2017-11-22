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
    
    func add(marker: GMSMarker) {
        if !markers.contains(marker) {
            markers.append(marker)
        }
    }
    
    func add(markers: [GMSMarker]) {
        markers.forEach {self.add(marker: $0)}
    }
    
    func remove(marker: GMSMarker) {
        markers = markers.filter({$0 != marker})
    }
    
    func remove(markers: [GMSMarker]) {
        markers.forEach({ self.remove(marker: $0)})
    }
    
    func dispose() {
        markers.removeAll()
    }
    
}
