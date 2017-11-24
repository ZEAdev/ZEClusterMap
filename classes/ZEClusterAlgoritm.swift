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
    func cluster(markers: [MarkerTuple], on map: ZEClusterMapView?, completion: @escaping ([ClusteredMarkerLists]?) -> Void) {
        
        guard let map = map else {
            completion(nil)
            return
        }
        
        var separateMarkerGroups = [ClusteredMarkerLists]()
        
        var markersToCluster = markers
        if map.clusterSettings.clusterOnlyVisibleMarkers == true {
            markersToCluster = markers.filter({map.projection.contains($0.marker.position)})
        }
        
        DispatchQueue.global(qos: .background).async {
            markersToCluster.forEach { (markerInfo) in
                if let idx = separateMarkerGroups.index(where: {$0.tag == markerInfo.tag}) {
                    separateMarkerGroups[idx].markers.append(markerInfo.marker)
                } else {
                    separateMarkerGroups.append(([markerInfo.marker], markerInfo.tag))
                }
            }
            
            separateMarkerGroups = separateMarkerGroups.map({ return (self.clusteringRound(markers: $0.markers, radius: map.visibleRegionScale * map.clusterSettings.clusterScale, minPerCluster: map.clusterSettings.minimumMarkersInCluster), $0.tag)})
            DispatchQueue.main.async {
                completion(separateMarkerGroups)
            }
        }
    }
    
    func clusteringRound(markers: [GMSMarker], radius: CLLocationDistance, minPerCluster: Int) -> [GMSMarker] {
        var clusteredMarkersArray = markers
        
        markers.forEach { (marker) in
            if clusteredMarkersArray.index(of: marker) != nil {
               let markersInCluster = clusteredMarkersArray.filter({ return marker.distanceTo(marker: $0) < radius })
                if markersInCluster.count >= minPerCluster {
                    let newClusterMarker = ZEClusterMarker()
                    newClusterMarker.add(markers: markersInCluster)
                    
                    clusteredMarkersArray = clusteredMarkersArray.filter({ return markersInCluster.contains($0) == false })
                    clusteredMarkersArray.append(newClusterMarker)
                }
            }
        }
        
        return clusteredMarkersArray

    }
    
}
