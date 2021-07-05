//
//  GeneralTutorialPlayView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 16/03/21.
//

import SwiftUI
/**
 Vista de la primera parte de jugar
 */
@available(iOS 13.0, *)
struct GeneralTutorialPlayView: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("TutorialGroundScan").resizable()
                    .scaledToFit()
                    .frame(height: 220.0)
            Image("Intro02Play02").resizable()
                    .scaledToFit()
                    .frame(width: 280.0)

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).padding(20).animation(.easeIn)
    }
}
@available(iOS 13.0, *)
struct GeneralTutorialPlayView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTutorialPlayView()
    }
}
