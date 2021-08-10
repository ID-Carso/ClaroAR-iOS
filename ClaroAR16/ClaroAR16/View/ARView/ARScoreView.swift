//
//  ARScoreView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import SwiftUI
/**
 Vista que contiene los elementos del header de la pantalla de seleccion de contenidos RA contiene los botones :
 -  contiene los botones de retorno a la app principal de ClaroShop
 - Score para el contenido de tipo Jugar
 - Boton de ayuda por tipo de contenido, es decir muestra la vista de HelpView con base al contenido activo
 TODO: retorno de navegacion a la app de Claroshop
 */

@available(iOS 13.0, *)
struct ARScoreView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var Score: Int
    @Binding var CanShowHelp: Bool
    @Binding var SelectedType: TypeContent
    @Binding var WillShowTutorial: Bool
    var body: some View {
        ZStack(alignment: .top){
            Image("ARScoreBG").resizable()
                .rotationEffect(.degrees(180))
                .frame(maxWidth: .infinity, maxHeight: 168)
            HStack(){
                
                Button(action: {
                    withAnimation(.easeOut){
                        presentationMode.wrappedValue.dismiss()
                    }
              
                }){
                    Image("ARBackBtnD")
                        .resizable()
                            .scaledToFit()
                            .frame(width: 30.0)
                }
                Spacer()
                if self.SelectedType == TypeContent.Jugar{
                    VStack(){
                        Text("Score").foregroundColor(.white)
                        Text("\(self.Score)").foregroundColor(.white)
                    }.frame(alignment: .center)
                }
                Spacer()
                Button(action: {
                    withAnimation(.easeOut){
                        if(self.SelectedType == TypeContent.None || self.SelectedType == TypeContent.Ofertas || self.SelectedType == TypeContent.Filtros){
                            self.WillShowTutorial = true
                        }
                        else{
                            self.CanShowHelp = true
                        }
                    }
              
                }){
                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .foregroundColor(.white)
                            .scaledToFit()
                            .frame(width: 30.0)
                }.frame(alignment: .trailing)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .frame(maxWidth: .infinity)
        }.frame(maxWidth: .infinity)

    }
}


