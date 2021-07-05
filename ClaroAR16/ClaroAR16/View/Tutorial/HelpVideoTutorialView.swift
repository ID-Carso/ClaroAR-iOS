//
//  HelpVideoTutorialView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 25/03/21.
//

import SwiftUI

/**
 Vista que contiene el video de ayuda por tipo de contenido
 */
@available(iOS 13.0, *)
struct HelpVideoTutorialView: View {
    @Binding var helpType: HelpView.HelpType
    var VideoLink: String
    var body: some View {
        ZStack(){
            HStack(){
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
            TutorialVideoHelp(helpType: self.$helpType, player: PlayerUIView(frame: .zero, url: URL(string: VideoLink)!))
            VStack(){
                Button(action: {
                    self.helpType = .General
                }){
                    Image("TutorialCloseVideo")
                        .resizable()
                            .scaledToFit()
                            .frame(height: 50.0)
                }.frame(alignment: .leading)
                .padding(.vertical, 10)
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
        }
    }
}

/*
 struct HelpVideoTutorialView_Previews: PreviewProvider {
     static var previews: some View {
         HelpVideoTutorialView()
     }
 }

 */
