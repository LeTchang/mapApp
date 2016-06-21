//
//  Location.swift
//  MapApp
//
//  Created by Tchang on 21/06/16.
//  Copyright © 2016 Tchang. All rights reserved.
//

import UIKit

class Location: NSObject {

    private let name: String
    private let longitude: Double
    private let latitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.longitude = longitude
        self.latitude = latitude
    }
    
    // MARK: - Getter
    func getName() -> String {
        return self.name
    }
    
    func getLongitude() -> Double {
        return self.longitude
    }
    
    func getLatitude() -> Double {
        return self.latitude
    }
}
