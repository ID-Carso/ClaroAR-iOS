//
//  GeneralTutorialPlay02View.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 22/03/21.
//

import SwiftUI
/**
 Vista de la segunda parte de jugar
 */
@available(iOS 13.0, *)
struct GeneralTutorialPlay02View: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("Intro02Play03").resizable()
                    .scaledToFit()
                    .frame(height: 220.0)
            Image("Intro02Play04").resizable()
                    .scaledToFit()
                    .frame(width: 280.0)
            Image("Intro02Play05").resizable()
                    .scaledToFit()
                    .frame(height: 21.0)

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).animation(.easeIn)
    }
}
@available(iOS 13.0, *)
struct GeneralTutorialPlay02View_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTutorialPlay02View()
    }
}
