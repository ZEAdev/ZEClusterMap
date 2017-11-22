//
//  ViewController.swift
//  ZECluster
//
//  Created by Zhenya Zhornitsky on 01.11.2017.
//  Copyright © 2017 Zhenya Zhornitsky. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createMap() {
        
        let mapView = ZEClusterMapView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), renderer: ZETestRenderer())

    }
    

}

class ZETestRenderer: NSObject, ZEClusterRendererProtocol {
    
}

