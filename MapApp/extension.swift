//
//  extension.swift
//  MapApp
//
//  Created by Tchang on 21/06/16.
//  Copyright © 2016 Tchang. All rights reserved.
//

import UIKit
import MapKit

extension String {
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
    }
}

extension MKMapView {
    
    func annotation(name: String, latitude: Double, longitude: Double) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = name
        annotation.subtitle = "Maybe someone knows this place..."
        self.addAnnotation(annotation)
    }
}