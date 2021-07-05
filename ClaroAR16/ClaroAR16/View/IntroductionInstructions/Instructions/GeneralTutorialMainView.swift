//
//  GeneralTutorialMainView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 16/03/21.
//

import SwiftUI
/*
 Vista que contiene los elementos visuales de la pantalla de titorial general del tutorial del inicio de modulo de RA
 */
@available(iOS 13.0, *)
struct GeneralTutorialMainView: View {
    @Binding var  WillShowTutorial: Bool 
    @State var NumberView: TutorialView = TutorialView.Intro
    enum TutorialView {
        case Intro
        case Scan
        case Discover
        case Play01
        case Play02
        case Filter
        case Sale
        case Start
    }
    var body: some View {
        VStack(){
            GeneralHeaderTutorialView(NumberView: $NumberView).frame(maxWidth: .infinity)
            Spacer()
            switch NumberView{
            case .Intro:
                withAnimation(.default){
                    GeneralIntroductionView()
                }
            case .Scan:
                withAnimation(.default){
                    GeneralTutorialScanView()
                }
            case .Discover:
                withAnimation(.default){
                    GeneralTutorialDiscoverView()               }
            case .Play01:
                withAnimation(.default){
                    GeneralTutorialPlayView()
                }
            case .Play02:
                withAnimation(.default){
                    GeneralTutorialPlay02View()
                }
            case .Filter:
                withAnimation(.default){
                    GeneralTutorialFilterView()
                }
            case .Sale:
                withAnimation(.default){
                    GeneralTutorialSaleView()
                }
            case .Start:
                withAnimation(.default){
                    GeneralTutorialStartView()
                }
            }
            Spacer()
            VStack(spacing: 20.0){
                HStack(){
                    Image("LoadingWait")
                        .resizable()
                        .scaledToFit()
                        .opacity(NumberView == TutorialView.Intro ? 1.0 : 0.4)
                        .frame(width: 10.0)
                    Image("LoadingWait")
                        .resizable()
                        .scaledToFit()
                        .opacity(NumberView == TutorialView.Scan ? 1.0 : 0.4)
                        .frame(width: 10.0)
                    Image("LoadingWait")
                        .resizable()
                        .scaledToFit()
                        .opacity(NumberView == TutorialView.Play01 ? 1.0 : 0.4)
                        .frame(width: 10.0)
                    Image("LoadingWait")
                        .resizable()
                        .scaledToFit()
                        .opacity(NumberView == TutorialView.Play02 ? 1.0 : 0.4)
                        .frame(width: 10.0)
                    Image("LoadingWait")
                        .resizable()
                        .opacity(NumberView == TutorialView.Discover ? 1.0 : 0.4)
                        .scaledToFit()
                        .frame(width: 10.0)
                    Image("LoadingWait")
                        .resizable()
                        .scaledToFit()
                        .opacity(NumberView == TutorialView.Sale ? 1.0 : 0.4)
                        .frame(width: 10.0)
                    Image("LoadingWait")
                        .resizable()
                        .scaledToFit()
                        .opacity(NumberView == TutorialView.Filter ? 1.0 : 0.4)
                        .frame(width: 10.0)
                    Image("LoadingWait")
                        .resizable()
                        .scaledToFit()
                        .opacity(NumberView == TutorialView.Start ? 1.0 : 0.4)
                        .frame(width: 10.0)
                }
                
                if NumberView == TutorialView.Start{
                    Button(action: {
                        withAnimation(.easeOut){
                            self.WillShowTutorial = false
                        }
                    }){
                        Image("IntroNext")
                            .resizable()
                                .scaledToFit()
                                .frame(height: 30.0)
                    }
                }
                
                
                if NumberView != TutorialView.Start{
                    withAnimation(){
                        Button(action: {
                            withAnimation(.easeOut){
                                self.WillShowTutorial = false
                            }
                        }){
                            Image("IntroStart" )
                                .resizable()
                                    .scaledToFit()
                                .frame(height: 40)
                        }
                    }
                }
                
            }.padding()
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.white)
        .highPriorityGesture(DragGesture().onEnded({
            (value) in
            if value.translation.width > 50{
                //print("Right")
                withAnimation(.default){
                    switch NumberView{
                    case .Intro:
                        NumberView = .Intro
                    case .Scan:
                        NumberView = .Intro
                    case .Play01:
                        NumberView = .Scan
                    case .Play02:
                        NumberView = .Play01
                    case .Discover:
                        NumberView = .Play02
                    case .Sale:
                        NumberView = .Discover
                    case .Filter:
                        NumberView = .Sale
                    case .Start:
                        NumberView = .Filter
                    }
                }
            }
            else if -value.translation.width > 50{
                //print("left")
                withAnimation(.default){
                    switch NumberView{
                    case .Intro:
                        NumberView = .Scan
                    case .Scan:
                        NumberView = .Play01
                    case .Play01:
                        NumberView = .Play02
                    case .Play02:
                        NumberView = .Discover
                    case .Discover:
                        NumberView = .Sale
                    case .Sale:
                        NumberView = .Filter
                    case .Filter:
                        NumberView = .Start
                    case .Start:
                        print("End")
                    }
                }
                
            }
        }))
    }
}




