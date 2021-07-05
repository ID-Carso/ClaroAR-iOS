//
//  FileValidator.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation

/**
 Esta clase estatica se encarga de modificar la carpeta de soporte de la app
 teniendo las siguientes funciones:
    -   Obtener urls de archivos existentes
    -   Eliminar archivos
    -   valida si un archivo existe
    -   Obtine los nombres de archivos
 */

class FileValidator {
    /**
     Obtiene la url de una archivo de la carpeta de soporte de la app
     - Parameter fileName: nombre del archvo del que se desea obtener la URL
     - Returns: URL al archivo, esta URL puede ser nula ya que el archivo puede o no existir
     */
    static func GetFileURL(fileName: String)-> URL?{
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            if let pathComponent = url.appendingPathComponent(fileName) {
                print("==== DEBUG: FILE PATH \(pathComponent)")
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                
                if fileManager.fileExists(atPath: filePath) {
                    print("==== DEBUG: FILE AVAILABLE")
                    return pathComponent
                } else {
                    print("==== DEBUG: FILE NOT AVAILABLE")
                }
            } else {
                print("==== DEBUG: FILE PATH NOT AVAILABLE")
                
            }
        return nil
    }
    
    /**
     Obtiene el Path de una archivo de la carpeta de soporte de la app
     - Parameter fileName: nombre del archvo del que se desea obtener el Path
     - Returns: String del Path al archivo, este Path puede ser nula ya que el archivo puede o no existir
     */
    static func CheckFileExist(fileName: String) -> String?{
        let path = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true)[0] as String
            let url = NSURL(fileURLWithPath: path)
            if let pathComponent = url.appendingPathComponent(fileName) {
                print("==== DEBUG: FILE PATH \(pathComponent)")
                let filePath = pathComponent.path
                let fileManager = FileManager.default
                
                if fileManager.fileExists(atPath: filePath) {
                    print("==== DEBUG: FILE AVAILABLE")
                    return filePath
                } else {
                    print("==== DEBUG: FILE NOT AVAILABLE")
                }
            } else {
                print("==== DEBUG: FILE PATH NOT AVAILABLE")
                
            }
        return nil
    }
    
    /**
     Obtiene la url de todos los archivos de tipo reality de la carpeta de soporte de la app
     - Returns: Arreglo de URL a todos los archivos existentes de tipo reality, este arreglo puede ser o no nulo dependiendo si hay archivos reality previamente guardados o no
     */
    static func listFilesFromAppSupportFolder() -> [URL]?
    {
        let documentsUrl =  FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        do {
            // obtiene el contenido de la ur, incluyendo subcarpetas
            let directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
            print(directoryContents)
            //filtra los contenidos por tipo extension
            let realityFiles = directoryContents.filter{ $0.pathExtension == "reality" }
            return realityFiles

        } catch {
            print(error)
            return nil
        }
        
    }
    
    /**
     Obtiene los nombres de los archivos dado un arreglo de URLS
     - Parameter urlFiles: arreglo con las URLs de los archivos
     - Returns: retorna un arreglo de tipo String con los nombres de los archivos de las URLs
     */
    static func ListFilesNameFromSupportFolder(urlFiles: [URL]) -> [String] {
        var filesName : [String] = []
        for file in urlFiles{
            filesName.append(file.lastPathComponent)
        }
        return filesName
    }
    
    /**
     Elimina un archivo usando una url
     - Parameter realityFileURL: URL al archivo a eliminar
     */
    static func DeleteFile(realityFileURL: URL){
        do{
            let fileManager = FileManager.default
            try fileManager.removeItem(at: realityFileURL)
        }
        catch{
            print("DEBUG ERROR: \(realityFileURL.lastPathComponent) couldn't be deleted, \(error)")
        }
    }
    
    /**
     Valida si el archivo de una url existe
     - Parameter urlFile: URL al archivo
     - Returns: retorna un Bool, true si el archivo existe sino regresa false
     */
    func CheckFileExist(urlFile: URL) -> Bool {
        let fileManager = FileManager.default
        
        return fileManager.fileExists(atPath: urlFile.path)
    }
}


extension Array where Element: Hashable {
    /**
     Funcion que devuelve los elementos diferentes entre dos Arrays
     - Parameter from other: Array que se comparara con el Array que invoco la funcion
     - Returns: Array con los elementos diferentes entre los Arrays
     */
    func difference(from other: [Element]) -> [Element] {
        let thisSet = Set(self)
        let otherSet = Set(other)
        return Array(thisSet.symmetricDifference(otherSet))
    }
}


