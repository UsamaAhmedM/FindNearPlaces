//
//  GMSCustomMarker.swift
//  Maddar
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

import GoogleMaps


class GMSCustomMarker: GMSMarker {
        
    init(_ coordinate: CLLocationCoordinate2D,_ placeType: PlacesTypes,_ placeName:String ) {
            super.init()
            position = coordinate
            icon = UIImage(named: placeType.rawValue+"PlaceHolder")
            title=placeName
            groundAnchor = CGPoint(x: 0.5, y: 1)
            appearAnimation = .pop
        }
    }

