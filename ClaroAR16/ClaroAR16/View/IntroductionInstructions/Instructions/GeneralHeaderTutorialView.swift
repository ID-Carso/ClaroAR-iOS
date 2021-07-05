//
//  GeneralHeaderTutorialView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 22/03/21.
//

import SwiftUI
/**
 Vista de emcabezado de la pantalla de tutorial general 
 */
@available(iOS 13.0, *)
struct GeneralHeaderTutorialView: View {
    @Binding var NumberView: GeneralTutorialMainView.TutorialView
    var body: some View {
        HStack(){
            switch NumberView{
            case GeneralTutorialMainView.TutorialView.Play01:
                Image("Intro08Header02").resizable().scaledToFit().frame(width: 146.0, height: 32.0, alignment: .center)
            case GeneralTutorialMainView.TutorialView.Play02:
                    Image("Intro08Header02").resizable().scaledToFit().frame(width: 146.0, height: 32.0, alignment: .center)
            case GeneralTutorialMainView.TutorialView.Discover:
                Image("Intro08Header03").resizable().scaledToFit().frame(width: 146.0, height: 32.0, alignment: .center)
            case GeneralTutorialMainView.TutorialView.Scan:
                Image("Intro08Header04").resizable().scaledToFit().frame(width: 146.0, height: 32.0, alignment: .center)
            case GeneralTutorialMainView.TutorialView.Sale:
                Image("Intro08Header05").resizable().scaledToFit().frame(width: 146.0, height: 32.0, alignment: .center)
            case GeneralTutorialMainView.TutorialView.Filter:
                Image("Intro08Header06").resizable().scaledToFit().frame(width: 146.0, height: 32.0, alignment: .center)
            default:
                EmptyView()
            }
            //Spacer()
           
            
        }
        .animation(.default)
        .frame(maxWidth: .infinity).background(Color.white).padding(.vertical, 20)
        .padding(.horizontal, 20)
        
    }
}


