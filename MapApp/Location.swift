//
//  Location.swift
//  MapApp
//
//  Created by Tchang on 21/06/16.
//  Copyright © 2016 Tchang. All rights reserved.
//

import UIKit

class Location: NSObject {

    let name: String
    let longitude: Double
    let latitude: Double
    
    init(name: String, longitude: Double, latitude: Double) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
}
