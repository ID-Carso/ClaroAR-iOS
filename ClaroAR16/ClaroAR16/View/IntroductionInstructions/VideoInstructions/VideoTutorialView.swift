//
//  VideoTutorialView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 25/03/21.
//

import SwiftUI
/**
 Vista del tutorial inicial
 */
@available(iOS 13.0, *)
struct VideoTutorialView: View {
    @State var hasFinishedVideo: Bool = false
    @State var NextHasBeenPressed: Bool = false
    @Binding var  WillShowTutorial: Bool
    var videoLink: String 
    
    
    var body: some View {
        ZStack(){
            if hasFinishedVideo || NextHasBeenPressed{
                GeneralTutorialMainView(WillShowTutorial: self.$WillShowTutorial)
            }
            else{
                HStack(){}.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black)
                TutorialVideo(hasFinishedVideo: $hasFinishedVideo, player: PlayerUIView(frame: .zero, url: URL(string: videoLink)!))
                HStack(){
                    Button(action: {
                        withAnimation(.easeOut){
                            
                        }
                  
                    }){
                        Image("Intro08Header01")
                            .resizable()
                                .scaledToFit()
                                .frame(width: 32.0)
                            .shadow(radius: 5)
                    }.frame(alignment: .leading)
                    .padding( 20)
                    Spacer()
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                
                VStack(){
                    Button(action: {
                        self.NextHasBeenPressed = true
                        //print("Has finisehd \(self.hasFinishedVideo)")
                  
                    }){
                        Image("IntroNext")
                            .resizable()
                                .scaledToFit()
                                .frame(height: 30.0)
                    }.frame(alignment: .leading)
                    .padding(.vertical, 20)
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
        }
    }
}


 /*
 struct VideoTutorialView_Previews: PreviewProvider {
     static var previews: some View {
         VideoTutorialView()
     }
 }


 */
