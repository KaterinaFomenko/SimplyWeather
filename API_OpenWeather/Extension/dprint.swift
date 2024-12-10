//
//  dprint.swift
//  API_OpenWeather
//
//  Created by Катерина Фоменко on 03/11/2024.
//

import Foundation
import UIKit

enum LogType: String {
    case api = "API"
    case cellView = "Cell"
    case vc = "vc"
    case always = "Always"
}

protocol Logable {
    var logOn: Bool { get set }
}


class d {
    
    static func print(_ str: String, _ source: Logable) {
        if source.logOn {
            Swift.print(str)
        }
    }
    
}
