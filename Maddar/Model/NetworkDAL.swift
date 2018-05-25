//
//  NetworkDAL.swift
//  Maddar
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import SwiftyJSON

public class NetworkDAL{
    
    private static let baseUrl = "https://maps.googleapis.com/";
    
    
    static internal func sharedInstance () ->(NetworkDAL)
    {
        struct Singleton {
            static let instance = NetworkDAL();
        }
        
        return Singleton.instance;
        
    }
    private init(){}
    
    internal func processReq(URLSuffix urlSuffix:String,
                             parser: @escaping (_ JSON:JSON) ->[Any],
                             onSuccess: @escaping (_ placesList:[Any])->Void,
                             onFailure:  @escaping (_ networkError:ErrorType)->Void
        )-> Void{
        
        Alamofire.request(NetworkDAL.baseUrl+urlSuffix).validate().responseJSON { response  in
            switch response.result {
            case .success(let data):
                let jsonData = JSON(data);
                print(response.request!.url!.absoluteString)
                onSuccess(parser(jsonData));
                
            case .failure( _):
                onFailure(ErrorType.internet)
            }
        }
        
    }
    
}
