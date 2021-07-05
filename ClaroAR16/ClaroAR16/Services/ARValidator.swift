//
//  ARValidator.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 30/03/21.
//

import Foundation
import ARKit
/**
 Clase que contiene metodos de tipo estatico para validar la compatibilidad con ARKit
 */
class ARValidator {
    /**
     Valida si el telefono es compatible con ARKit o no
     - Returns: Un tipo Bool, verdadero si el la app es compatible y false si no lo es
     */
    static func CheckCompatibility() -> Bool {
        return ARConfiguration.isSupported
    }
}
