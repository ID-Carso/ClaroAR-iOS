//
//  GeneralIntroductionView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 16/03/21.
//

import SwiftUI
/**
 Vista de instrucciones generales
 */
@available(iOS 13.0, *)
struct GeneralIntroductionView: View {
    
    var body: some View {
        VStack(spacing: 40){
            Spacer()
            Image("Intro01Wellcome01").resizable()
                .scaledToFit()
                .frame(width: 278)
            
            Image("Intro01Wellcome03").resizable()
                .scaledToFit()
                .frame(width: 200)

           Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).animation(.easeIn)
    }
}

/*
 struct GeneralIntroductionView_Previews: PreviewProvider {
     static var previews: some View {
         GeneralIntroductionView()
     }
 }
*/
