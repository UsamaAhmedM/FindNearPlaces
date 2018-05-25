//
//  Parser.swift
//  Maddar
//
//  Created by Admin on 5/24/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation
import SwiftyJSON

class Parser{
    public static func parsePlacesApiJson(_ jsonData:JSON) ->[Any]
{
    var resultArr:Array<Results>?
    do
    {
        let decoder = JSONDecoder()
        let apiResult = try decoder.decode(ApiResult.self, from: jsonData.rawData());
        resultArr=apiResult.results;
    }catch (let e)  {
       print(e)
    }
    return resultArr!
}
    
    public static func parseDestinationApiJson(_ jsonData:JSON) ->[Any]
    {
        var resultArr:Array<String>?
            resultArr = [
               ((((jsonData["rows"].arrayValue).first!)["elements"].arrayValue).first!)["distance"]["text"].stringValue]
        return resultArr!
    }
    
    public static func parseRouteApiJson(_ jsonData:JSON) ->[Any]
    {
        var resultArr:Array<String>?
        resultArr = [
            (jsonData["routes"].arrayValue).first!["overview_polyline"]["points"].stringValue]
        return resultArr!
    }
}
