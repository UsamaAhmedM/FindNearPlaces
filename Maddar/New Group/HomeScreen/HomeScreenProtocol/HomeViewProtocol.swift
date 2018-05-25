//
//  ViewProtocol.swift
//  Maddar
//
//  Created by Admin on 5/23/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import Foundation

enum ErrorType:String,Error{
    case internet = "Check your internet connection"
    case location = "Allow app to use location in order to continue"
    case parse
}

protocol HomeViewProtocol {
  func updateMarkersOnMap(_ array:[Any]) -> Void
  func showError(_ msg: ErrorType)  -> Void
    func showSpinner() -> Void ;
}
