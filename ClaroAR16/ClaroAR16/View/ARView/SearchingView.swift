//
//  SearchingView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 25/03/21.
//

import SwiftUI
/**
 Vista que muestra el maracdor de buscando 
 */
@available(iOS 13.0, *)
struct SearchingView: View {
    @State private var isLoading = false
    let Duration: Double = 1.0
    
    var body: some View {
        VStack(alignment: .center){
           
            Image("ARSearchImage").resizable()
                .scaledToFit()
                .frame(height: 150)
            
        }
        .opacity(isLoading ? 1 : 0.4)
        .animation(Animation.easeInOut(duration:
        Duration).repeatForever(autoreverses: true))
        .onAppear() {
            self.isLoading = true
        }
         
    }
}
@available(iOS 13.0, *)
struct SearchingView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingView()
    }
}
