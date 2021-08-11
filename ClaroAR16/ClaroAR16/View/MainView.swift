//
//  MainView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import SwiftUI

// com.americamovil.ClaroAr16
/**
 Vista principal en donde se gestiona el flujo general del modulo
 */
@available(iOS 13.0, *)
struct MainView: View {
    var dismissAction: (() -> Void)
    @ObservedObject var selectionViewModel: SelectionViewModel = SelectionViewModel()
    
    var body: some View {
        ZStack(){
            
            ClaroARViewContainer(Score: $selectionViewModel.Score, HasSelectedItem: $selectionViewModel.HasSelectedItem, hasFinishedLoadingFile: $selectionViewModel.hasFinishedLoadingFile, hasFinishedShowFile: $selectionViewModel.hasFinishedShowFile, ArEntities: $selectionViewModel.ArEntities, SelectedType: $selectionViewModel.SelectedType, CanShowHelp: $selectionViewModel.CanShowHelp, IsSearching: $selectionViewModel.IsSearching).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            if selectionViewModel.IsSearching{
                SearchingView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            ARSelectionBtnsView(SelectedType: $selectionViewModel.SelectedType, HasChooseType: $selectionViewModel.HasSelectedItem, ArEntities: $selectionViewModel.ArEntities, hasFinishedLoadingFile: $selectionViewModel.hasFinishedLoadingFile, hasFinishedShowFile: $selectionViewModel.hasFinishedShowFile, CanShowHelp: $selectionViewModel.CanShowHelp, dismissAction: dismissAction).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                
                
                
            ARScoreView(Score: $selectionViewModel.Score, CanShowHelp: $selectionViewModel.CanShowHelp, SelectedType: $selectionViewModel.SelectedType, WillShowTutorial: $selectionViewModel.WillShowTutorial, dismissAction: dismissAction).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            
            if selectionViewModel.WillShowTutorial && selectionViewModel.hasFinishedLoadingData{
                VideoTutorialView(WillShowTutorial: $selectionViewModel.WillShowTutorial, dismissAction: dismissAction, videoLink: (selectionViewModel.ArEntities[.Video]?.ContentLink)!)
            }
             
            
            if selectionViewModel.CanShowHelp && !selectionViewModel.WillShowTutorial {
                HelpView(SelectedType: $selectionViewModel
                            .SelectedType, CanShowHelp: $selectionViewModel.CanShowHelp, ArEntities: $selectionViewModel.ArEntities)
            }
            
            if (((!selectionViewModel.hasFinishedLoadingFile && !selectionViewModel.hasFinishedShowFile) && selectionViewModel.HasSelectedItem)) && !selectionViewModel.WillShowTutorial
            {
                LoadingFileView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            if !selectionViewModel.hasFinishedLoadingData{
                LoadingView().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            }
            
            
            
        }
    }
}

