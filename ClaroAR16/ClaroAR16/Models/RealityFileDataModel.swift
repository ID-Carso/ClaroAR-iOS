//
//  RealityFileDataModel.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
/**
 Estructura modela los contenidos de AR que seran almacenados en un diccionario de datos para el funcionamiento de la app
 */
struct RealityFileDataModel {
    let ContentLink: String?
    let SceneName: String?
    let shasum: String
    var FilePath: String?
    var TutorialTextLink: [Int: Data]?
    var TutorialImageLink: [Int: Data]?
    let ModelLink: String?
    let FileName: String?
}

