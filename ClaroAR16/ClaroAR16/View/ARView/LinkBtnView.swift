//
//  LinkBtnView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 18/03/21.
//

import SwiftUI
/**
 Vista de boton de sereccion de contenido que unicamente abre un Link
 */
@available(iOS 13.0, *)
struct LinkBtnView: View {
    @Binding var SelectedType: TypeContent
    @Binding var  ArEntities: [TypeContent : RealityFileDataModel]
    @Binding var HasChooseType: Bool
    @Binding var hasFinishedLoadingFile: Bool
    @Binding var hasFinishedShowFile: Bool
    var ActiveImageBtn: String
    var InactiveImageBtn: String
    var SelectionType: TypeContent
    var WidthBtn: CGFloat
    var WidthCircle: CGFloat
    var VerticalPadding : CGFloat
    var dismissAction: (() -> Void)
    var isSocial: Bool
    
    var body: some View {
        Button(action: {
            print("Selected Model")
            withAnimation(.easeOut){
                self.SelectedType = SelectionType
                OpenURL(url: (self.ArEntities[self.SelectedType]?.ContentLink)!)
                self.SelectedType = .Escanear
                self.HasChooseType = true
                self.hasFinishedLoadingFile = true
                self.hasFinishedShowFile = false
            }
        }){
            ZStack(alignment: .top){
                if self.SelectedType == SelectionType
                {
                    Image(ActiveImageBtn)
                    .resizable()
                    .scaledToFit()
                    .frame(width: WidthCircle)
                        .foregroundColor(.white)

                }
                Image(InactiveImageBtn)
                .resizable()
                .scaledToFit()
                .frame(width: WidthBtn)
                .padding(.vertical, VerticalPadding)
            }
        }
    }
}


@available(iOS 13.0, *)
extension LinkBtnView{
    func OpenURL(url: String)
    {
        var finalUrl = url;
        
        if(!isSocial)
        {
            finalUrl = "csclarora://" + url
        }
        
        guard let url = URL(string: finalUrl) else {
             return
        }
        
        
        
        if UIApplication.shared.canOpenURL(url) {
             UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
        if(!isSocial)
        {
            dismissAction()
        }
    }
}
