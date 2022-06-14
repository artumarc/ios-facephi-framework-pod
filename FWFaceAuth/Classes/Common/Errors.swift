//
//  Errors.swift
//  FWFaceAuth
//
//  Created by Grecia Escárcega on 10/01/20.
//

import Foundation

enum NetworkErrors: Error {
    case Error1
}

enum InstructionModuleErros: Error {
    case JSON_PARSE_ERROR
}

enum Common: Error {
    case DATA_CONVERSION_ERROR
}

enum AppError {
    case ConnectionError
    case AuthenticationError
    case ServiceError
}
