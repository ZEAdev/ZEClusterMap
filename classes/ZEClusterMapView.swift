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
    private(set) var unclusteredMarkers: [MarkerTuple]
    
    // getter for markers witch is contained in clusters
    private(set) var clusteredMarkers: [ClusteredMarkerLists]
    
    // renderer
    private var renderer: ZEClusterRendererProtocol!
    
    // clusterAlgoritm
    private var algoritm: ZEClusterAlgorimtProtocol!
    
    var clusterRadius: CLLocationDistance = 2000000
    
    required init?(coder aDecoder: NSCoder) {
        clusteredMarkers = [ClusteredMarkerLists]()
        unclusteredMarkers = [MarkerTuple]()
        super.init(coder: aDecoder)
        
    }
    
    // public methods
    
    convenience init(frame: CGRect, renderer: ZEClusterRendererProtocol) {
        self.init(frame: frame, renderer: renderer, algoritm: ZEDefaultClusterAlgoritm())
    }
    
    init(frame: CGRect, renderer: ZEClusterRendererProtocol, algoritm: ZEClusterAlgorimtProtocol ) {
        clusteredMarkers = [ClusteredMarkerLists]()
        unclusteredMarkers = [MarkerTuple]()
        
        super.init(frame: frame)
        self.renderer = renderer
        self.algoritm = algoritm
    }
    
    func add(marker: GMSMarker!, with tag: String?) {
        unclusteredMarkers.append((marker, tag))
        marker.map = self
    }
    
    func cluster() {
        if let algoritm = algoritm as? ZEDefaultClusterAlgoritm {
            algoritm.clusteringRadius = clusterRadius
        }
        let unclusteredMarkers = self.unclusteredMarkers
        self.clear()
        clusteredMarkers = algoritm.cluster(markers: unclusteredMarkers)
        
        clusteredMarkers.forEach { (tuple) in
            tuple.markers.forEach({$0.map = self})
        }
        self.unclusteredMarkers = unclusteredMarkers
    }
    
    override func clear() {
        unclusteredMarkers.removeAll()
        clusteredMarkers.removeAll()
        super.clear()
    }
    
}
