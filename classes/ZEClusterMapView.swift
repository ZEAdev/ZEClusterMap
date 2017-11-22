//
//  ZEClusterMapView.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit
import GoogleMaps

class ZEClusterMapView: GMSMapView {
    
    // getter for unclustered markers on the map
    private(set) var unclusteredMarkers: [markerTuple]
    
    // getter for markers witch is contained in clusters
    private(set) var clusteredMarkers: [markerTuple]
    
    // renderer
    private var renderer: ZEClusterRendererProtocol!
    
    // clusterAlgoritm
    private var algoritm: ZEClusterAlgorimtProtocol!
    
    var clusterRadius: CLLocationDistance = 200
    
    required init?(coder aDecoder: NSCoder) {
        clusteredMarkers = [markerTuple]()
        unclusteredMarkers = [markerTuple]()
        super.init(coder: aDecoder)
    }
    
    // public methods
    
    convenience init(frame: CGRect, renderer: ZEClusterRendererProtocol) {
        self.init(frame: frame, renderer: renderer, algoritm: ZEDefaultClusterAlgoritm())
    }
    
    init(frame: CGRect, renderer: ZEClusterRendererProtocol, algoritm: ZEClusterAlgorimtProtocol ) {
        clusteredMarkers = [markerTuple]()
        unclusteredMarkers = [markerTuple]()
        
        super.init(frame: frame)
        self.renderer = renderer
        self.algoritm = algoritm
    }
    
    func add(marker: GMSMarker!, with tag: String?) {
        unclusteredMarkers.append((marker, tag))
        marker.map = self
    }
    
    func cluster() {
        
    }
    
}
