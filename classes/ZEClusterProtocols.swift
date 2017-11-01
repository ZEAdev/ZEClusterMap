//
//  ZEClusterProtocols.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit

protocol ZEClusterRenderer: NSObjectProtocol {
    
}

protocol ZEClusterAlgorimtProtocol: NSObjectProtocol {
    func cluster(markers: [markerTuple]) -> [clusteredMarkerLists]
}
