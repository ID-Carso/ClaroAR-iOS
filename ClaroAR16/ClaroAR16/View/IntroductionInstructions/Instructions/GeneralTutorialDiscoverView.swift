//
//  GeneralTutorialDiscoverView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 16/03/21.
//

import SwiftUI
/**
 Vista del tutorial de descubrir
 */
@available(iOS 13.0, *)
struct GeneralTutorialDiscoverView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("Intro03Discover01").resizable()
                    .scaledToFit()
                    .frame(height: 220.0)
            Image("Intro03Discover02").resizable()
                    .scaledToFit()
                    .frame(width: 280.0)
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).padding(20).animation(.easeIn)
    }
}
@available(iOS 13.0, *)
struct GeneralTutorialDiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTutorialDiscoverView()
    }
}
