//
//  PlacesBL.swift
//  Maddar
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import CoreLocation
import SwiftyJSON

enum PlacesTypes:String{
    case bank
    case mosque
    case currentLocation
}
enum RouteTypes:String{
    case driving
    case walking
}
class PlacesBL {
    
    private var model :NetworkDAL?;
    private let raduis:Double=10000;
    static internal func sharedInstance () ->(PlacesBL)
    {
        struct Singleton {
            static let instance = PlacesBL();
        }
        return Singleton.instance;
    }
    private init(){
        model=NetworkDAL.sharedInstance();
    }
    
    internal func getPlaces(CurrentLocation coordinate:CLLocationCoordinate2D,
                            PlaceType type:PlacesTypes,
        onSuccess:@escaping ([Any])->Void,
        onFailure:@escaping (_ error:ErrorType)->Void
        )->Void{
        
        let urlSuffix:String="maps/api/place/nearbysearch/json?location=\(coordinate.latitude),\(coordinate.longitude)&radius=\(self.raduis)&type=\(type.rawValue)&key=\(AppDelegate.MAPS_API_KEY)"
        model!.processReq(
            URLSuffix:urlSuffix,
            parser:Parser.parsePlacesApiJson ,
            onSuccess: onSuccess ,
            onFailure:onFailure);
    }
    
    
    internal func getRoute(UserLocationCoordinate coordinate:CLLocationCoordinate2D,
                           UserDestinationCoordinate destCoordinate:CLLocationCoordinate2D,
                           onFinalSuccess:@escaping (_ url:String)->Void,
                            onFailure:@escaping (_ error:ErrorType)->Void
        )->Void{
        let urlSuffixDriving:String="/maps/api/directions/json?origin=\(coordinate.longitude),\(coordinate.latitude)&destination=\(destCoordinate.longitude),\(destCoordinate.latitude)&mode=\(RouteTypes.driving)&key=\(AppDelegate.MAPS_API_KEY)"
        let urlSuffixWalking:String="/maps/api/directions/json?origin=\(coordinate.longitude),\(coordinate.latitude)&destination=\(destCoordinate.longitude),\(destCoordinate.latitude)&mode=\(RouteTypes.walking)&key=\(AppDelegate.MAPS_API_KEY)"
        model!.processReq(
            URLSuffix:urlSuffixDriving,
            parser:Parser.parseRouteApiJson ,
            onSuccess:  {(arrDriving:[Any]) in
                self.model!.processReq(
                    URLSuffix:urlSuffixWalking,
                    parser:Parser.parseRouteApiJson ,
                    onSuccess:  {(arrWalking:[Any]) in
                        let apiUrl:String = "https://maps.googleapis.com/maps/api/staticmap?scale=1&size=300x300&maptype=roadmap&markers=color:blue|label:S|\(coordinate.longitude),\(coordinate.latitude)&markers=color:red|label:D|\(destCoordinate.longitude),\(destCoordinate.latitude)&path=weight:10|color:green|enc:\(arrWalking.first!)&path=weight:3|color:red|enc:\(arrDriving.first!)&key=\(AppDelegate.MAPS_API_KEY)"
                        onFinalSuccess(apiUrl)
                },
                    onFailure:onFailure);
                },
            onFailure:onFailure)
    }
    internal func getDistance(UserLocationCoordinate coordinate:CLLocationCoordinate2D,
                           UserDestinationCoordinate destCoordinate:CLLocationCoordinate2D,
                           onSuccess:@escaping (_ url:String)->Void,
                           onFailure:@escaping (_ error:ErrorType)->Void
        )->Void{
        let urlSuffix:String="/maps/api/distancematrix/json?units=metric&language=en&origins=\(coordinate.longitude),\(coordinate.latitude)&destinations=\(destCoordinate.longitude),\(destCoordinate.latitude)&key=\(AppDelegate.MAPS_API_KEY)"
       
        model!.processReq(
            URLSuffix:urlSuffix,
            parser:Parser.parseDestinationApiJson,
            onSuccess:  {(distance:[Any]) in
              onSuccess(distance.first! as! String)
        },
            onFailure:onFailure)
    }
    }
    


