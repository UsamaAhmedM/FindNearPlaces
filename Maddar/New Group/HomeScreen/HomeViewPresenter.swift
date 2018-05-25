//
//  HomeViewPresenter.swift
//  Maddar
//
//  Created by Admin on 5/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation

class HomeViewPresenter {
  public var viewDelegate: HomeViewProtocol?
  public var userLocation:CLLocation?;
    public var currentSearch:PlacesTypes?;
  private var model:PlacesBL?;
    init() {
        model=PlacesBL.sharedInstance();
    }
    
  public func requestBanksInArea()->Void{
    guard let location=userLocation else{
        viewDelegate!.showError(ErrorType.location)
        return
    }
        
    if(currentSearch == nil || currentSearch! != PlacesTypes.bank )
    {
        viewDelegate!.showSpinner()
        currentSearch=PlacesTypes.bank;
    model!.getPlaces(CurrentLocation: location.coordinate,
                     PlaceType: .bank, onSuccess: self.viewDelegate!.updateMarkersOnMap(_:),
                     onFailure: viewDelegate!.showError(_:))
    }
    }
  public func requestMosquesInArea()->Void{
    guard let location=userLocation else{
        viewDelegate!.showError(ErrorType.location)
        return
    }
    
    if(currentSearch == nil || currentSearch! != PlacesTypes.mosque )
    {
         viewDelegate!.showSpinner()
        currentSearch=PlacesTypes.mosque;
        model!.getPlaces(CurrentLocation: location.coordinate,
                         PlaceType: .mosque, onSuccess: self.viewDelegate!.updateMarkersOnMap(_:),
                         onFailure: viewDelegate!.showError(_:))
    }}
    
    func showError(withMsg msg: ErrorType) {
        viewDelegate?.showError(msg)
    }
}

