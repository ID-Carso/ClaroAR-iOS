//
//  GeneralTutorialFilterView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 22/03/21.
//

import SwiftUI
/**
 Vista de filtros del tutorial general
 */
@available(iOS 13.0, *)
struct GeneralTutorialFilterView: View {
    @available(iOS 13.0.0, *)
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("Intro05Filter01").resizable()
                .scaledToFit()
                .frame(height: 240.0)
            Image("Intro05Filter02").resizable()
                .scaledToFit()
                .frame(width: 280.0)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).animation(.easeIn)
    }
}
@available(iOS 13.0, *)
struct GeneralTutorialFilterView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTutorialFilterView()
    }
}
