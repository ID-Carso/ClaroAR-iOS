//
//  SelectionBtnView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import SwiftUI
import CryptoKit
/**
 Vista del Boton para seleccion de contenido RA
 */
@available(iOS 13.0, *)
struct SelectionBtnView: View {
    @Binding var SelectedType: TypeContent
    @Binding var HasChooseType: Bool
    @Binding var  ArEntities: [TypeContent : RealityFileDataModel]
    @Binding var hasFinishedLoadingFile: Bool
    @Binding var hasFinishedShowFile: Bool
    @Binding var CanShowHelp: Bool
    var ActiveImageBtn: String
    var InactiveImageBtn: String
    var SelectionType: TypeContent
    var WidthBtn: CGFloat
    var WidthCircle: CGFloat
    var VerticalPadding : CGFloat
    
    var body: some View {
        Button(action: {
            print("Selected Model")
            withAnimation(.easeOut){
                if !self.HasChooseType{
                    self.SelectedType = SelectionType
                    self.HasChooseType = true
                    self.hasFinishedLoadingFile = false
                    self.hasFinishedShowFile = false
                    //self.CanShowHelp = true
                    DownLoadRealiotyFileFile(file: (ArEntities[self.SelectedType]?.FileName)!)
                }
            }
        }){
            ZStack(alignment: .top){
               
                if self.SelectedType == SelectionType
                {
                    Image(ActiveImageBtn)
                    .resizable()
                    .scaledToFit()
                        .frame(width: WidthCircle)

                }
                Image(InactiveImageBtn)
                .resizable()
                .scaledToFit()
                .frame(width: WidthBtn)
                    .padding(.vertical, VerticalPadding)
            }
        }
    }
}
@available(iOS 13.0, *)
extension SelectionBtnView{
    /**
     Esta funcion descarga el archivo reality del contenido seleccionado
     */
    func DownloadRealityFile()  {
        let link : String? = self.ArEntities[self.SelectedType]?.ModelLink
        let fileN : String? = self.ArEntities[self.SelectedType]?.FileName
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
        if let urlFile = FileValidator.GetFileURL(fileName: file){
            if let data = NSData(contentsOfFile: urlFile.path)
            {
                let hash = SHA256.hash(data: data)
                let hashString = "\(hash)"
                let hashServer : String = self.ArEntities[self.SelectedType]!.shasum
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

