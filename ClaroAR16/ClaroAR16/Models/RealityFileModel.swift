//
//  RealityFileModel.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//


import Foundation

/**
 Modelo de contenido desde servidor 
 */
struct RealityFileModel : Decodable {
    let FileName: String?
    let SceneName: String?
    let ModelLink: String?
    let ContentLink: String?
    let TutorialTextLink: [String]?
    let TutorialImageLink: [String]?
    let isActive: Bool
    let shasum: String
    let typeContent: TypeContent
}

/**
 Enum que representa los tipos de contenidos posibles desde servidor
 */
enum TypeContent: String, Decodable {
    case Escanear = "Escanear"
    case Jugar = "Jugar"
    case Conocer = "Conocer"
    case Video = "Video"
    case Ofertas = "Ofertas"
    case Filtros = "Filtros"
    case None = "None"
    
    init(from decoder: Decoder) throws {
        let label = try decoder.singleValueContainer().decode(String.self)
        self = TypeContent(rawValue: label) ?? .None
      }
}
struct RealityFilesModel: Decodable {
    let realities: [RealityFileModel]
}



