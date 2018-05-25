//
//  ShowViewProtol.swift
//  Maddar
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation
protocol ShowRoadProtocol {
    var source:CLLocationCoordinate2D{get}
    var destination:CLLocationCoordinate2D{get}
    func updateRouteImage(_ url:String) -> Void
    func updateDistanceLabel(_ distance:String) -> Void
    func showError(_ msg: ErrorType)  -> Void
}
