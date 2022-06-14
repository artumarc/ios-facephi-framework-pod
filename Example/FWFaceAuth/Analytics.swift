//
//  Analytics.swift
//  FWFaceAuth_Example
//
//  Created by Carlos H. Torres on 07/05/20.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation
import FirebaseAnalytics

var Evento_Analytics: Dictionary = [String: String]()

class AnalyticsFace{
    func registrarEvento(event_name: String, paramteters: [String: Any], calledIn: String? = nil)
       {
           var params = [String : NSObject]()
           let Event_var_ = paramteters.compactMapValues { $0 }
           
           for items in Event_var_ {
               
               params.updateValue(items.value as! NSObject, forKey: items.key)
               Analytics.setUserProperty("\(items.value)", forName: items.key)
           }
           
           print("START_registrarEvento: llamado en: \(String(describing: calledIn)) firebase_event_name: \(event_name) firebase_parameters: \(params)")
           
           
           Analytics.logEvent(event_name, parameters:  params)
           Evento_Analytics = [:]
           
           print("END_registrarEvento: llamado en: \(String(describing: calledIn)) firebase_event_name: \(event_name) firebase_parameters: \(params)")
       }
}
