//
//  GeneralTutorialSaleView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 22/03/21.
//

import SwiftUI
/**
 Vista de ofertas de tutorial general
 */
@available(iOS 13.0, *)
struct GeneralTutorialSaleView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("Intro06Sale01").resizable()
                .scaledToFit()
                .frame(height: 240.0)
            Image("Intro06Sale02").resizable()
                .scaledToFit()
                .frame(width: 280.0)
            Image("Intro06Sale03").resizable()
                .scaledToFit()
                .frame(height: 21.0)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).animation(.easeIn)
    }
}
@available(iOS 13.0, *)
struct GeneralTutorialSaleView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTutorialSaleView()
    }
}
