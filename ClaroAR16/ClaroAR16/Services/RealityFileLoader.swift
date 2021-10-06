//
//  RealityFileLoader.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import RealityKit
import Combine

/**
 Carga el conetinido de los archivos reality y los retorna como un Entity
 */
@available(iOS 13.0, *)
public class RealityFileLoader{
    var streams = [Combine.AnyCancellable]()
    
    /**
     Carga el contenido de los archivor reality
     - Parameters:
        - filePath: Path del archivo reality
        - sceneName: Nombre de la escena principal del archivo reality
        - completion: Escape cuando la operacion es exitosa, puede retornar un tipo Entity o un error
     */
    func loadRealityComposerSceneAsync (filePath: String,
                                         sceneName: String,
                                         completion: @escaping (Swift.Result<(Entity)?, Swift.Error>) -> Void) {
         
         guard let realityFileSceneURL = createRealityURL(filePath: filePath, sceneName: sceneName) else {
             print("Error: Unable to find specified file in application bundle")
            
            
             return
         }
         
         let loadRequest =  Entity.loadAnchorAsync(contentsOf: realityFileSceneURL)
         let cancellable = loadRequest.sink(receiveCompletion: { (loadCompletion) in
             if case let .failure(error) = loadCompletion {
                 completion(.failure(error))
             }
         }, receiveValue: { (entity) in
             
             completion(.success(entity))
         })
         cancellable.store(in: &streams)
     }
    /**
     Obtiene la URL del archivo reality para la carga de su contenido
     - Parameters:
        - filePath: Path del archivo reality
        - sceneName: Nombre de la escena principal del archivo reality
     - Returns: URL al archivo, esta URL puede ser nula ya que el archivo puede o no existir
     */
     func createRealityURL(filePath: String,
                           sceneName:String) -> URL? {
         let realityFileURL = URL(fileURLWithPath: filePath)
         if realityFileURL.isFileURL{
             print("DEBUG: Url creada para \(filePath)")
             let realityFileSceneURL = realityFileURL.appendingPathComponent(sceneName, isDirectory: false)
             return realityFileSceneURL
         }
         else{
             return nil
         }
     }
}
