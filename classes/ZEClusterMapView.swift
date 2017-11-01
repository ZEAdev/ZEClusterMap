//
//  ZEClusterMapView.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit
import GoogleMaps

typealias markerTuple = (marker: GMSMarker, tag: String?)
typealias clusteredMarkerLists = (markers: [GMSMarker], tag: String?)

class ZEClusterMapView: GMSMapView {
    
    // getter for unclustered markers on the map
    private(set) var unclusteredMarkers: [markerTuple]
    
    // getter for markers witch is contained in clusters
    private(set) var clusteredMarkers: [markerTuple]
    
    // renderer
    private var renderer: ZEClusterRenderer!
    
    required init?(coder aDecoder: NSCoder) {
        clusteredMarkers = [markerTuple]()
        unclusteredMarkers = [markerTuple]()
        super.init(coder: aDecoder)
    }
    
    // public methods
    
    init(frame: CGRect, renderer: ZEClusterRenderer) {
        clusteredMarkers = [markerTuple]()
        unclusteredMarkers = [markerTuple]()
        
        super.init(frame: frame)
        self.renderer = renderer
    }
    
    func add(marker: GMSMarker, with tag: String?) {
        unclusteredMarkers.append((marker, tag))
    }
    
    func cluster() {
        
    }
    
}
