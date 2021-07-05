//
//  LoadingView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import SwiftUI




/**
 Vista de carga, esta vista se muestra unicamente al inicio del modulo cuando se estan cargando los datos de los contenidos activos de RA y las imagenes de los tutoriales por contenidos
 */
//@available(iOS 13.0, *)
//import iActivityIndicator
struct LoadingView: View {
    var body: some View {
        VStack(alignment: .center){
            
            LoadingWaitView(Size: CGSize(width: 160, height: 160), ImagesNames: ["LoadingScanText","LoadingPlayText","LoadingTakeText","LoadingEnjoyText"]).frame(width: 160, height: 160, alignment: .center)
            
            LoadingWaitView(Size: CGSize(width: 300, height: 300), ImagesNames: ["LoadingScan","LoadingPlay","LoadingTake","LoadingEnjoy"]).frame(width: 300)
                
                
            Spacer()
            
            HStack(alignment: .center, spacing: 15) {
                CircleView() // 1.
                CircleView(delay: 0.2) // 2.
                CircleView(delay: 0.4) // 3.
            }.frame(width: 80, height: 50)
            
            //iActivityIndicator(style: .rowOfShapes(count: 3, scaleRange: 0.8...1)).foregroundColor(.orange).frame(width: 80, height: 50)
            Image("LoadingWaitText").resizable()
                .scaledToFit()
                .frame(height: 20)
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(Color.white)
    }
}
//@available(iOS 13.0, *)
struct LoadingCircleView: View {
    @State private var isLoading = false
    let Duration: Double
    
    var body: some View {
        VStack(alignment: .center){
           
            Image("LoadingWait").resizable()
                .scaledToFit()
                .frame(height: 10)
            
        }
        .opacity(isLoading ? 1 : 0.4)
        .animation(Animation.easeInOut(duration:
        Duration).repeatForever(autoreverses: true))
        .onAppear() {
            self.isLoading = true
        }
         
    }
}

//@available(iOS 13.0, *)
struct LoadingWaitView: View {
    @State private var isLoading = false
    let Size: CGSize
    let ImagesNames: [String]
    
    var body: some View {
        VStack(alignment: .center){
           
            AnimatedImagesView(imageSize: Size, imageNames: ImagesNames, duration: 8).aspectRatio(contentMode: .fit)
                
         
            /*AnimatedImagesView(imageSize: CGSize(width: 300, height: 300), imageNames: ["LoadingScan","LoadingPlay","LoadingTake","LoadingEnjoy"], duration: 8)*/
            
        }
        .opacity(isLoading ? 1 : 0)
        .animation(Animation.easeInOut(duration: 1).repeatForever(autoreverses: true))
        .onAppear() {
            self.isLoading = true
        }
         
    }
}

//@available(iOS 13.0, *)
 struct LoadingView_Previews: PreviewProvider {
     static var previews: some View {
         LoadingView()
     }
 }
 
