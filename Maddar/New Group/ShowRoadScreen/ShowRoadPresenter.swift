//
//  ShowRoadPresenter.swift
//  Maddar
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class ShowRoadPresenter {
    
    public var viewDelegate: ShowRoadProtocol?
    
    
    
    private var model:PlacesBL?;
    init() {
        model=PlacesBL.sharedInstance();
    }
    func getStaticMap()-> Void
    {
        model?.getRoute(UserLocationCoordinate: viewDelegate!.source, UserDestinationCoordinate: viewDelegate!.destination,
                        onFinalSuccess: (viewDelegate?.updateRouteImage)!, onFailure: (viewDelegate?.showError)!);
    }
    func getDistance()-> Void
    {
        model?.getDistance(UserLocationCoordinate: viewDelegate!.source, UserDestinationCoordinate: viewDelegate!.destination,
                           onSuccess: (viewDelegate?.updateDistanceLabel)!, onFailure: (viewDelegate?.showError)!);
        
    }
    
}
