//
//  NetworkingProvider.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import Alamofire
/**
 Clase con metodos estaticos que se encargan de las peticiones HTTPS del modulo de RA
 */
class NetworkingProvider {
    /**
     Descarga una imagen
     - Requires: El link de descarga debe de tener el protocolo HTTPS
     - Parameters:
        - url: link a la imagen a descargar
        - success: escape cuando la peticion ha sido exitosa, regresa el Data de la imagen
        - failure: escape cuando la peticion falla, regresa un error
     */
    static func GetImage(url: String, success: @escaping (_ imageContent : Data) -> (), failure: @escaping (_ error: Error?) -> ())
    {
        var urlcheck = url
        if !urlcheck.contains("https:"){
            urlcheck = urlcheck.replacingOccurrences(of: "http:", with: "https:")
        }

        AF.download(urlcheck)
            .downloadProgress { progress in
                print("Download \(url) Progress : \(progress.fractionCompleted)")
            }
            .responseData { response in
                if let data = response.value {
                    success(data)
                }
                else
                {
                    failure(response.error)
                }
            }

    }
    /**
    Descarga un archivo desde una url y lo guarda en la carpeta de soporte de la app, en caso de que ya exista lo sobre escribe
      - Requires: El link de descarga debe de tener el protocolo HTTPS
      - Parameters:
         - url: link al archivo a descargar
         - success: escape cuando la peticion ha sido exitosa, regresa el Path del archivo una vez guardado en la carpeta de soporte de la app
         - failure: escape cuando la peticion falla, regresa un error
     */
    static func DownloadFile(url: String, filename: String, success: @escaping (_ content : String) -> (), failure: @escaping( _ error: Error?)->() ){
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(filename)

            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        var urlcheck = url
        if !urlcheck.contains("https:"){
            urlcheck = urlcheck.replacingOccurrences(of: "http:", with: "https:")
        }

        
        AF.download(urlcheck, to: destination)
            .downloadProgress { progress in
                print("Download \(filename) Progress: \(progress.fractionCompleted)")
            }
            .responseData { response in
                if response.error == nil, let FilePath = response.fileURL?.path{
                    success(FilePath)
                }
                else
                {
                    failure(response.error)
                }
            }
    }
    /**
     Obtiene los contenidos activos del servidor a partir de un JSON, retorna un arreglo con los contenidos Activos
     - Requires: El link de descarga debe de tener el protocolo HTTPS
     - Parameters:
        - url: Link al json con los datos de los contenidos activos
        - success: escape cuando la peticion ha sido exitosa, regresa un arreglo de tipo RealityFileModel
        - failure: escape cuando la peticion falla, regresa un error
     */
    static func GetRealityFilesData( url: String, success: @escaping (_ Files: [RealityFileModel]) -> (), failure: @escaping (_ error: Error?)-> ()) {
        var urlcheck = url
        if !urlcheck.contains("https:"){
            urlcheck = urlcheck.replacingOccurrences(of: "http:", with: "https:")
        }

        AF.request(urlcheck, method: .get).validate(statusCode: 200...299).responseDecodable(of: RealityFilesModel.self){
            filesData in
            if let files = filesData.value?.realities{
                var realityFile : [RealityFileModel] = []
                for file in files{
                    if file.isActive{
                        //print("\(file.FileName) \(file.SceneName) \(file.typeContent)")
                        realityFile.append(file)
                    }
                }
                success(realityFile)
            }
            else{
                failure(filesData.error)
            }
        }
    }
    
}

