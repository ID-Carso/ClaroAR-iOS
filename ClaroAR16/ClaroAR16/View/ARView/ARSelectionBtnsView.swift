//
//  ARSelectionBtnsView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import SwiftUI
/**
 Vista de la pantalla de Seleccion de contenidos RA
 */
@available(iOS 13.0, *)
struct ARSelectionBtnsView: View {
    @Binding var SelectedType: TypeContent
    @Binding var HasChooseType: Bool
    @Binding var  ArEntities: [TypeContent : RealityFileDataModel]
    @Binding var hasFinishedLoadingFile: Bool
    @Binding var hasFinishedShowFile: Bool
    @Binding var CanShowHelp: Bool

    
    var body: some View {
        ZStack(alignment: .center){
            Image("ARScoreBG").resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: 241)
            HStack(alignment: .top, spacing: 20){
                SelectionBtnView(SelectedType: self.$SelectedType, HasChooseType: self.$HasChooseType, ArEntities: $ArEntities, hasFinishedLoadingFile: self.$hasFinishedLoadingFile, hasFinishedShowFile: self.$hasFinishedShowFile, CanShowHelp: self.$CanShowHelp, ActiveImageBtn: "ARActive", InactiveImageBtn: "ARPlay", SelectionType: TypeContent.Jugar, WidthBtn: 45, WidthCircle: 55, VerticalPadding: 5)
                    
                SelectionBtnView(SelectedType: self.$SelectedType, HasChooseType: self.$HasChooseType, ArEntities: $ArEntities, hasFinishedLoadingFile: self.$hasFinishedLoadingFile, hasFinishedShowFile: self.$hasFinishedShowFile, CanShowHelp: self.$CanShowHelp, ActiveImageBtn: "ARActive", InactiveImageBtn: "ARKnow", SelectionType: TypeContent.Conocer, WidthBtn: 56, WidthCircle: 56, VerticalPadding: 5)
                    
                SelectionBtnView(SelectedType: self.$SelectedType, HasChooseType: self.$HasChooseType, ArEntities: $ArEntities, hasFinishedLoadingFile: self.$hasFinishedLoadingFile, hasFinishedShowFile: self.$hasFinishedShowFile, CanShowHelp: self.$CanShowHelp, ActiveImageBtn: "ARActive", InactiveImageBtn: "ARScan", SelectionType: TypeContent.Escanear, WidthBtn: 65, WidthCircle: 60, VerticalPadding: -3).frame(alignment: .top)
                
                LinkBtnView(SelectedType: self.$SelectedType, ArEntities: self.$ArEntities, HasChooseType: self.$HasChooseType, hasFinishedLoadingFile: self.$hasFinishedLoadingFile, hasFinishedShowFile: self.$hasFinishedShowFile, ActiveImageBtn: "ARActive", InactiveImageBtn: "ARSale-1", SelectionType: TypeContent.Ofertas, WidthBtn: 50, WidthCircle: 55, VerticalPadding: 5)
                
                LinkBtnView(SelectedType: self.$SelectedType, ArEntities: self.$ArEntities, HasChooseType: self.$HasChooseType, hasFinishedLoadingFile: self.$hasFinishedLoadingFile, hasFinishedShowFile: self.$hasFinishedShowFile, ActiveImageBtn: "ARActive", InactiveImageBtn: "ARFilters", SelectionType: .Filtros, WidthBtn: 45, WidthCircle: 60, VerticalPadding: 5)
                
            }
            .frame(maxWidth: .infinity)
            .padding(.bottom, 60)
            .padding(.horizontal, 10)
            .padding(.top, 20)
        }
    }
}


