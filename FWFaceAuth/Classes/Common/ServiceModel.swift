//
//  ServicesModels.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 18/01/20.
//  Copyright © 2020 Grecia Escárcega. All rights reserved.
//

import Foundation

enum ServiceModel {
    
    struct OAuth: Codable {
        
        let accessToken: String
        let organization_name: String
        let token_type: String
        let issued_at: String
        let nombre: String
        let client_id: String
        let application_name: String
        let scope: String
        let expires_in: String
        let refresh_count: String
        let status: String

        enum CodingKeys: String, CodingKey {
            case accessToken = "access_token", organization_name, token_type, issued_at, nombre, client_id, application_name, scope, expires_in, refresh_count, status
        }
    }
    
    struct AuthenticatorEnroller: Codable {
        
        let result: Bool
        let errorNegocio: ErrorNegocio?

        enum CodingKeys: String, CodingKey {
            case result = "resultado"
            case errorNegocio = "error_negocio"
        }
    }
    
    struct ErrorNegocio: Codable {
        
        let codigo: Int?
        let detalle: String?

        enum CodingKeys: String, CodingKey {
            case codigo = "codigo"
            case detalle = "detalle"
        }
    }
    
    struct AuthenticatorEnrollerString: Codable {
        
        let result: Bool
        let errorNegocio: ErrorNegocioString?

        enum CodingKeys: String, CodingKey {
            case result = "resultado"
            case errorNegocio = "error_negocio"
        }
    }
    
    struct ErrorNegocioString: Codable {
        
        let codigo: String?
        let detalle: String?

        enum CodingKeys: String, CodingKey {
            case codigo = "codigo"
            case detalle = "detalle"
        }
    }
}
