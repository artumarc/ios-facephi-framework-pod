//
//  Constants.swift
//  FirebaseCore
//
//  Created by Grecia Escárcega on 01/04/20.
//

import Foundation

struct Constants {
    
    struct Debug {
        static let active = false
        static var idRequest: Int?
        static var curp: String?
        static var client: String?
        static let origin = "ios"
    }
    
    #if DEBUG
    static let url = "https://api.dev.profuturo.mx"
    static let usr = "THs1H8T7P5SDH2IEMpj8DufGZLy9YBdD"
    static let pss = "Et8D1J08uP0wOSf5"
    static let license = "license-debug"
    static let notValidateCurp = true
    #elseif QA
    /*static let url = "https://api.qa.profuturo.mx"
    static let usr = "MoM7QBbEy34fmwfGgTtSUHXkSKaXA3Vf"
    static let pss = "ys2czAKo9Ex6DXUp"
    static let license = "license-debug"
    static let notValidateCurp = true*/
    static let url = "https://api.dev.profuturo.mx"
    static let usr = "THs1H8T7P5SDH2IEMpj8DufGZLy9YBdD"
    static let pss = "Et8D1J08uP0wOSf5"
    static let license = "license-debug"
    static let notValidateCurp = true
    #else
    static let url = "https://api.profuturo.mx"
    static let usr = "6Yu14kJIF9cKaHv5ghT044JUbUMjlxqx"
    static let pss = "kMX00Z6sREeA16r7"
    static let license = "license-debug"
    static let notValidateCurp = false
    #endif
    
    
    
    /*static let url = "https://api.profuturo.mx"
    static let usr = "6Yu14kJIF9cKaHv5ghT044JUbUMjlxqx"
    static let pss = "kMX00Z6sREeA16r7"
    static let license = "license-release"
    static let notValidateCurp = true
    #else
    static let url = "https://api.dev.profuturo.mx"
    static let usr = "THs1H8T7P5SDH2IEMpj8DufGZLy9YBdD"
    static let pss = "Et8D1J08uP0wOSf5"
    static let license = "license-debug"
    static let notValidateCurp = true
    #endif*/
}
