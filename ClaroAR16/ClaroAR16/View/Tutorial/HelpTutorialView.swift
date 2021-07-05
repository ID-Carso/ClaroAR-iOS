//
//  HelpTutorialView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import SwiftUI
/**
 Vista que contiene las imagenes del tutorial del tipo de contenido
 */
@available(iOS 13.0, *)
struct HelpTutorialView: View {
    @Binding var SelectedType: TypeContent
    @Binding var CanShowHelp: Bool
    @Binding var  ArEntities: [TypeContent : RealityFileDataModel]
    @Binding var helpType: HelpView.HelpType
    @State var IndexPage: Int = 0
    
    var body: some View {
        VStack(){
            VStack(spacing:40){
                
                VStack(alignment: .center, spacing: 40){
                    VStack(alignment: .center, spacing: 20){
                        if ArEntities[SelectedType] != nil{
                            if ArEntities[SelectedType]?.TutorialImageLink![IndexPage] != nil{
                                Image(uiImage: UIImage(data: (ArEntities[SelectedType]?.TutorialImageLink![IndexPage])!)!).resizable()
                                    .scaledToFit()
                                    .frame(width: 250.0)
                            }
                            if ArEntities[SelectedType]?.TutorialTextLink![IndexPage] != nil{
                                Image(uiImage: UIImage(data: (ArEntities[SelectedType]?.TutorialTextLink![IndexPage])!)!).resizable()
                                    .scaledToFit()
                                    .frame(width: 214.0)
                            }
                        }
                        
                        
                    }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center).padding(20)
                    if ArEntities[SelectedType] != nil{
                        if ArEntities[SelectedType]?.TutorialImageLink != nil{
                            if (ArEntities[SelectedType]?.TutorialImageLink!.count)! > 1{
                                HStack(spacing: 40){
                                    Button(action: {
                                        IndexPage = IndexPage - 1
                                        if IndexPage <= 0
                                        {
                                            IndexPage = 0
                                        }
                                    }){
                                        Image("TutorialBackBtn")
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(IndexPage == 0 ? 0.4 : 1)
                                            .frame(height: 32.0)
                                    }
                                    Button(action: {
                                        IndexPage = IndexPage + 1
                                        if IndexPage > ((ArEntities[SelectedType]?.TutorialImageLink!.count)! - 1)
                                        {
                                            IndexPage = (ArEntities[SelectedType]?.TutorialImageLink!.count)! - 1
                                        }
                                    }){
                                        Image("TutorialForwardBtn")
                                            .resizable()
                                            .scaledToFit()
                                            .opacity(IndexPage == ((ArEntities[SelectedType]?.TutorialImageLink!.count)! - 1) ? 0.4 : 1)
                                            .frame(height: 32.0)
                                    }
                                }
                            }
                        }
                    }
                    
                }

                
                VStack(){
                    Button(action: {
                        withAnimation(.easeOut){
                            self.CanShowHelp = false
                        }
                  
                    }){
                        Image("TutorialOKBtn")
                            .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                    }
                    
                    Button(action: {
                        withAnimation(.easeOut){
                            self.helpType = .Video
                        }
                  
                    }){
                        Image("TutorialGoVideo")
                            .resizable()
                                .scaledToFit()
                                .frame(height: 30)
                    }
                }
            }.frame(width: 240)
            .padding(50)
            .background(Color.white)
            .cornerRadius(30)
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.vertical, 20)
        .padding(.horizontal, 5)
        .background(Color.black.opacity(0.6))
    }
}

/*
 struct HelpTutorialView_Previews: PreviewProvider {
     static var previews: some View {
         HelpTutorialView()
     }
 }

 */
