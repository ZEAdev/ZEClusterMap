//
//  ZEClusterProtocols.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit
import GoogleMaps

typealias MarkerTuple = (marker: GMSMarker, tag: String?)
typealias ClusteredMarkerLists = (markers: [GMSMarker], tag: String?)

protocol ZEClusterRendererProtocol: NSObjectProtocol {
    
}

protocol ZEClusterAlgorimtProtocol: NSObjectProtocol {
    func cluster(markers: [MarkerTuple]) -> [ClusteredMarkerLists]
}
