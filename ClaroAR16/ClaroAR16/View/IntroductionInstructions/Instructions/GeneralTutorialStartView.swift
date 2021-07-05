//
//  GeneralTutorialStartView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 16/03/21.
//

import SwiftUI
/**
 Vista de la pantalla de cerrar tutorial general
 */
@available(iOS 13.0, *)
struct GeneralTutorialStartView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("Intro07Start01").resizable()
                .scaledToFit()
                .frame(height: 30.0)
            Image("LoadingEnjoy").resizable()
                .scaledToFit()
                .frame(height: 250.0)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).animation(.easeIn)
    }
}
@available(iOS 13.0, *)
struct GeneralTutorialStartView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTutorialStartView()
    }
}
