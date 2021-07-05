//
//  HelpView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 25/03/21.
//

import SwiftUI
/**
 Vista que contiene la pantalla de ayuda por tipo de contenido
 */
@available(iOS 13.0, *)
struct HelpView: View {
    @Binding var SelectedType: TypeContent
    @Binding var CanShowHelp: Bool
    @Binding var  ArEntities: [TypeContent : RealityFileDataModel]
    @State var helpType: HelpType = HelpType.Section
    enum HelpType{
        case Section
        case Video
        case General
    }
    var body: some View {
        ZStack(){
            switch helpType{
            case .Section:
                HelpTutorialView(SelectedType: self.$SelectedType, CanShowHelp: self
                                    .$CanShowHelp, ArEntities: self.$ArEntities, helpType: self.$helpType)
            case .Video:
                HelpVideoTutorialView(helpType: self.$helpType, VideoLink: (ArEntities[.Video]?.ContentLink)!)
            case .General:
                GeneralTutorialMainView(WillShowTutorial: $CanShowHelp)
            }
            
        }
    }
}

