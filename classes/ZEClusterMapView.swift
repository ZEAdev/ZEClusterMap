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
    
    // getter for unclustered markers on the map
    private(set) var clusteredMarkers: [ClusteredMarkerLists]

    // renderer
    private var renderer: ZEClusterRendererProtocol!
    
    // clusterAlgoritm
    private var algoritm: ZEClusterAlgorimtProtocol!
    
    /*
    // struct containing settings
    */
    var clusterSettings = ZEClusterSettings()
    
    required init?(coder aDecoder: NSCoder) {
        unclusteredMarkers = [MarkerTuple]()
        clusteredMarkers = [ClusteredMarkerLists]()
        super.init(coder: aDecoder)
    }
    
    // public methods
    
    convenience init(frame: CGRect, renderer: ZEClusterRendererProtocol) {
        self.init(frame: frame, renderer: renderer, algoritm: ZEDefaultClusterAlgoritm())
    }
    
    init(frame: CGRect, renderer: ZEClusterRendererProtocol, algoritm: ZEClusterAlgorimtProtocol ) {
        unclusteredMarkers = [MarkerTuple]()
        clusteredMarkers = [ClusteredMarkerLists]()
        
        super.init(frame: frame)
        self.renderer = renderer
        self.algoritm = algoritm
    }
    
    func add(marker: GMSMarker!, with tag: String?) {
        unclusteredMarkers.append((marker, tag))
        marker.map = self
    }
    
    func cluster() {
        weak var weakSelf = self
        algoritm.cluster(markers: unclusteredMarkers, on: weakSelf) { (clusteredMarkersLists) in
            if let clusteredMarkersLists = clusteredMarkersLists {
                super.clear()
                clusteredMarkersLists.forEach { (tuple) in
                    tuple.markers.forEach({ (marker) in
                        if let marker = marker as? ZEClusterMarker {
                            // render new icon
                            marker.icon = self.renderer.icon(count: marker.markers.count, tag: tuple.tag)
                            marker.position = marker.calculatePosition()
                        }
                        marker.map = self
                    })
                }
                self.clusteredMarkers = clusteredMarkersLists
            }
        }
        
    }
    
    override func clear() {
        unclusteredMarkers.removeAll()
        clusteredMarkers.removeAll()
        super.clear()
    }
    
}
