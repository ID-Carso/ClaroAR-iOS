//
//  SelectionViewModel.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import CryptoKit
/*
 Clase viewModel de la vista MainView, esta clase contiene todas las variables de control de la app
 **/
@available(iOS 13.0, *)
class SelectionViewModel: ObservableObject {
    @Published var  ArEntities: [TypeContent : RealityFileDataModel] = [:]
    @Published var SelectedType: TypeContent = TypeContent.None
    @Published var hasFinishedShowFile: Bool = false
    @Published var hasFinishedLoadingData: Bool = false
    @Published var WillShowTutorial: Bool = false
    @Published var hasFinishedLoadingFile: Bool = false
    @Published var HasSelectedItem : Bool = false
    @Published var Score: Int = 0
    @Published var IsSearching: Bool = true
    @Published var CanShowHelp: Bool = false
    var hasfinishedImages: [TypeContent:Bool] = [:]
    var hasfinishedText: [TypeContent:Bool] = [:]
    
    init() {
        
        // Valida si existe algun archivo de tipo reality para mostrar el tutorial de inicio
        if let realityFilesUrls = FileValidator.listFilesFromAppSupportFolder(){
            if realityFilesUrls.count == 0{
                WillShowTutorial = true
            }
        }
        else{
            WillShowTutorial = true
        }
        // Obtiene la informacion de los contenidos desde servidor
        NetworkingProvider.GetRealityFilesData(url: "https://arassetsinfinitum.objects-us-east-1.dream.io/json/realities.json")
         {
            filesData in
            
            for file in filesData{
                // almacena los datos de los contenidos en un diccionario de datos
                self.ArEntities[file.typeContent] = RealityFileDataModel(ContentLink: file.ContentLink, SceneName: file.SceneName, shasum: file.shasum, FilePath: "", TutorialTextLink: [:], TutorialImageLink:[:], ModelLink: file.ModelLink, FileName: file.FileName)
                if file.typeContent == .Conocer || file.typeContent == .Escanear || file.typeContent == .Jugar{
                    self.DownloadTutorialText(type: file.typeContent, urlsImages: file.TutorialTextLink!)
                    self.DownloadTutorialImages(type: file.typeContent, urlsImages: file.TutorialImageLink!)
                }
            }
            // valida si ha terminado la descarga de las imagenes tutoriales y procede a descargar el contenido de tipo escanear
            if self.hasfinishedText.count == 3 && self.hasfinishedImages.count == 3{
                self.hasFinishedLoadingData = true
                self.DownloadScan()
            }
         }
         failure: { (error) in
             print("Error: \(error.debugDescription)")
         }
    }
}
@available(iOS 13.0, *)
extension SelectionViewModel{
    /**
     Esta funcion descarga el contenido de tipo Escanear
     */
    func  DownloadScan(){
        if let escanearEntity = self.ArEntities[TypeContent.Escanear]{
            self.hasFinishedLoadingData = true
            self.SelectedType = .Escanear
            self.hasFinishedLoadingFile = false
            self.hasFinishedShowFile = false
            self.HasSelectedItem = true
            self.DownLoadRealiotyFileFile(file: escanearEntity.FileName!)

        }
        
    }
    
    /**
     Esta funcion descarga las imagenes de texto de la pantalla help de un contenido AR
     - Parameters:
        - type: Tipo de contenido del que se va a descargar la imagen, se utiliza para guardar la imagen en el diccionario de imagenes
        - urlsImages: Arreglo de Strings que contienen los links de descarga de las imagenes
     
     */
    func DownloadTutorialText(type: TypeContent, urlsImages: [String])  {
        for (n, link) in urlsImages.enumerated()
        {
             NetworkingProvider.GetImage(url: link)
             {
                 imageData in
                self.ArEntities[type]?.TutorialTextLink?[n] = imageData
                if self.ArEntities[type]?.TutorialTextLink?.count == urlsImages
                    .count{
                    self.hasfinishedText[type] = true
                    if self.hasfinishedText.count == 3 && self.hasfinishedImages.count == 3{
                        self.hasFinishedLoadingData = true
                        self.DownloadScan()
                    }
                }
             }
             failure: { (errorPath) in
                 print("Error: \(errorPath.debugDescription)")
             }
         }
    }
    /**
     Esta funcion descarga las imagenes de ayuda de la pantalla help de un contenido AR
     - Parameters:
        - type: Tipo de contenido del que se va a descargar la imagen, se utiliza para guardar la imagen en el diccionario de imagenes
        - urlsImages: Arreglo de Strings que contienen los links de descarga de las imagenes
     */
    func DownloadTutorialImages(type: TypeContent, urlsImages: [String])  {
        for (n, link) in urlsImages.enumerated()
        {
             NetworkingProvider.GetImage(url: link)
             {
                 imageData in
                self.ArEntities[type]?.TutorialImageLink?[n] = imageData
                if self.ArEntities[type]?.TutorialImageLink?.count == urlsImages
                    .count{
                    self.hasfinishedImages[type] = true
                    if self.hasfinishedText.count == 3 && self.hasfinishedImages.count == 3{
                        self.hasFinishedLoadingData = true
                        self.DownloadScan()
                    }
                }
             }
             failure: { (errorPath) in
                 print("Error: \(errorPath.debugDescription)")
             }
         }
    }
}

@available(iOS 13.0, *)
extension SelectionViewModel{
    /**
     Esta funcion descarga el archivo reality del contenido seleccionado
     */
    func DownloadRealityFile()  {
        let link : String? = self.ArEntities[self.SelectedType]?.ModelLink
        let fileN : String? = self.ArEntities[self.SelectedType]?.FileName
        //print("\(link) \(fileN)")
        DispatchQueue.main.async{
            
            NetworkingProvider.DownloadFile(url: link!, filename: fileN!)
            {
                filePath in
                //Se alamacena en un diccionario la informacion del contenido y el url al archivo reality
                self.ArEntities[self.SelectedType]?.FilePath = filePath
                self.hasFinishedLoadingFile = true
                
            }
            failure: { (errorPath) in
                print("Error: \(errorPath.debugDescription)")
            }
        }
    }
    
    
    /**
     Esta funcion valida si existe un archivo, en caso de que exista valida que la version del archivo sea la misma que la del servidor
     en caso de que lo sea anexa el Path del archivo en el diccionario de los contenidos reality, en caso contrario de que no sea el mismo
     que en servidor o no exista procede a descargarlo.
     - Parameter file: Nombre del archivo
     */
    func DownLoadRealiotyFileFile(file: String)  {
        //Obtiene la url al archivo
        if let urlFile = FileValidator.GetFileURL(fileName: file){
            // valida si existe el archivo
            if let data = NSData(contentsOfFile: urlFile.path)
            {
                // se codifica el archivo en formato shasum256
                let hash = SHA256.hash(data: data)
                let hashString = "\(hash)"
                let hashServer : String = self.ArEntities[self.SelectedType]!.shasum
                // compara la codificacion con la der archivo de servidor
                if hashString.contains(hashServer)
                {
                    self.ArEntities[self.SelectedType]?.FilePath = urlFile.path
                    self.hasFinishedLoadingFile = true
                }
                else{
                    DownloadRealityFile()
                }
        }
        else{
            DownloadRealityFile()
        }
    }
    else{
            DownloadRealityFile()
    }
    
    }
}
