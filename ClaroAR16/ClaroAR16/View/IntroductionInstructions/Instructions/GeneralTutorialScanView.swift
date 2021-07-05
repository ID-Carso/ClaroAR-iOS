//
//  GeneralTutorialScanView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 16/03/21.
//

import SwiftUI
/**
 Vista del tutorial de escanear
 */
@available(iOS 13.0, *)
struct GeneralTutorialScanView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 20){
            Image("TutorialBoxScan").resizable()
                .scaledToFit()
                .frame(height: 220.0)
            Image("Intro04Scan01").resizable()
                .scaledToFit()
                .frame(width: 280.0)
            Image("Intro04Scan02").resizable()
                .scaledToFit()
                .frame(height: 21.0)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).padding(20).animation(.easeIn)
    }
}
@available(iOS 13.0, *)
struct GeneralTutorialScanView_Previews: PreviewProvider {
    static var previews: some View {
        GeneralTutorialScanView()
    }
}
