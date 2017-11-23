//
//  ZEClusterAlgoritm.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import CoreLocation
import GoogleMaps

class ZEDefaultClusterAlgoritm: NSObject, ZEClusterAlgorimtProtocol {
    
    var clusteringRadius: CLLocationDistance = 0
    
    convenience init(clusteringRadius: CLLocationDistance) {
        self.init()
        self.clusteringRadius = clusteringRadius
    }
    
    func cluster(markers: [MarkerTuple]) -> [ClusteredMarkerLists] {
        var separateMarkerGroups = [ClusteredMarkerLists]()
        
        // markers into groups
        markers.forEach { (markerInfo) in
            if let idx = separateMarkerGroups.index(where: {$0.tag == markerInfo.tag}) {
                separateMarkerGroups[idx].markers.append(markerInfo.marker)
            } else {
                separateMarkerGroups.append(([markerInfo.marker], markerInfo.tag))
            }
        }
        separateMarkerGroups = separateMarkerGroups.map({ return (self.clusteringRound(markers: $0.markers), $0.tag)})
        
        return separateMarkerGroups
    }
    
    func clusteringRound(markers: [GMSMarker]) -> [GMSMarker] {
        var clusteredMarkersArray = markers
        guard var leftMarker = markers.first else {return markers}
        
        var idx = 0
        while idx < markers.count {
            let rightMarker = markers[idx]
            idx += 1
            
            if leftMarker == rightMarker {
                continue
            }
            
            if leftMarker.distanceTo(marker: rightMarker) < clusteringRadius {
                let newClusterMarker = ZEClusterMarker()
                newClusterMarker.add(markers: [leftMarker, rightMarker])
                
                if let idxLeft = clusteredMarkersArray.index(of: leftMarker) {clusteredMarkersArray.remove(at: idxLeft)}
                if let idxRight = clusteredMarkersArray.index(of: rightMarker) {
                    clusteredMarkersArray.remove(at: idxRight)
                    clusteredMarkersArray.insert(newClusterMarker, at: idxRight)
                }
                
                leftMarker = newClusterMarker
            } else {
                leftMarker = rightMarker
            }
        }

        return clusteredMarkersArray

    }
    
}
