//
//  LoadingFileView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 22/03/21.
//

import SwiftUI
/**
 Esta pantalla de carga se muestra cunado se esta descargando un archivo reality y cargando su contenido en la vista de ClaroARViewContainer
 */
@available(iOS 13.0, *)
struct LoadingFileView: View {
    var body: some View {
        VStack(){
            AnimatedImagesView(imageSize: CGSize(width: 67, height: 67), imageNames: ["Loading01", "Loading02", "Loading03", "Loading04", "Loading05", "Loading06", "Loading07", "Loading08"], duration: 0.8).frame(width: 67, height: 67, alignment: .center)
        }.frame(maxWidth: .infinity,  maxHeight: .infinity, alignment: .center)
        .background(Color.black.opacity(0.6))
    }
}
@available(iOS 13.0, *)
struct LoadingFileView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingFileView()
    }
}
