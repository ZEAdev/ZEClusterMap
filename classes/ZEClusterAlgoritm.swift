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
    
    var clusteringRadius: CLLocationDistance = 200
    
    convenience init(clusteringRadius: CLLocationDistance) {
        self.init()
        self.clusteringRadius = clusteringRadius
    }
    
    func cluster(markers: [markerTuple]) -> [clusteredMarkerLists] {
        var separateMarkerGroups = [clusteredMarkerLists]()
        
        // markers into groups
        markers.forEach { (markerInfo) in
            if var group = separateMarkerGroups.first(where:{$0.tag == markerInfo.tag}){
                group.markers.append(markerInfo.marker)
            } else {
                separateMarkerGroups.append(([markerInfo.marker], markerInfo.tag))
            }

            
            
        }
        
        return []
    }
    
    func clusteringRound(markers: [GMSMarker]) -> [GMSMarker] {
        var clusteredMarkersArray = markers
        guard var leftMarker = markers.first else {return markers}
        markers.forEach { (rightMarker) in
            if leftMarker.distanceTo(marker: rightMarker) < clusteringRadius {
                let newClusterMarker = ZEClusterMarker(position: leftMarker.middlePositionToMarker(marker: rightMarker))
//                newClusterMarker.
            }
            
        }
    }
    
}
