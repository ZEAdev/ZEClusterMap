//
//  ZEClusterExtensions.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 23.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//
import GoogleMaps

extension GMSMarker {
    func distanceTo(marker: GMSMarker!) -> CLLocationDistance {
        let myLocation = CLLocation(latitude: self.position.latitude, longitude: self.position.longitude)
        let markerLocation  = CLLocation(latitude: marker.position.latitude, longitude: marker.position.longitude)
        
        return myLocation.distance(from: markerLocation)
    }
    
    func middlePositionToMarker(marker: GMSMarker!) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake((self.position.latitude + marker.position.latitude)/2, (self.position.longitude + marker.position.longitude)/2)
    }
}

extension GMSMapView {
    var visibleRegionScale: CLLocationDistance {
        let leftPointLocation = CLLocation(latitude: projection.visibleRegion().nearLeft.latitude, longitude: projection.visibleRegion().nearLeft.longitude)
        let rightPointLocaiton = CLLocation(latitude: projection.visibleRegion().farLeft.latitude, longitude: projection.visibleRegion().farLeft.longitude)
        return leftPointLocation.distance(from: rightPointLocaiton)
    }
}
