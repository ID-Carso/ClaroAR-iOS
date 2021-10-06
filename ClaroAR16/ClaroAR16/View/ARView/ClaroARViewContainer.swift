//
//  ClaroARViewContainer.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import SwiftUI
import RealityKit

/**
 Estructura que contiene el comportamiento de RA, es decir:
 - instancia los objetos RA
 - Elimina los objetos que ya no se van a utilizar
 - Maneja los eventos de los contenidos de RAs
 */
@available(iOS 13.0, *)
struct ClaroARViewContainer: UIViewRepresentable {
    @State var ActiveEntity: Entity?
    @Binding var Score: Int
    @Binding var HasSelectedItem : Bool
    @Binding var hasFinishedLoadingFile: Bool
    @Binding var hasFinishedShowFile: Bool
    @Binding var ArEntities: [TypeContent : RealityFileDataModel]
    @Binding var SelectedType: TypeContent
    @Binding var CanShowHelp: Bool
    @Binding var IsSearching: Bool
    
    var arLoader: RealityFileLoader = RealityFileLoader()
    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)
        //arView.debugOptions.insert(.showStatistics)
        #if !targetEnvironment(simulator)
        let defaultScaleFactor = arView.contentScaleFactor
        arView.contentScaleFactor = 0.4 * defaultScaleFactor
        arView.renderOptions.insert(ARView.RenderOptions.disableDepthOfField)
        arView.renderOptions.insert(ARView.RenderOptions.disableAREnvironmentLighting)
        arView.renderOptions.insert(ARView.RenderOptions.disablePersonOcclusion)
        #endif
        
        return arView
    }
    
    func updateUIView(_ uiView: ARView, context: Context)
    {
        if self.SelectedType == .Filtros || self.SelectedType == .Ofertas{
            uiView.scene.anchors.removeAll()
            //DeleteAnchor()
        }
        else{
            
            if (self.HasSelectedItem && self.hasFinishedLoadingFile) && !CanShowHelp {
                DispatchQueue.main.async {
                    self.hasFinishedLoadingFile = false
                    uiView.scene.anchors.removeAll()
                    //DeleteAnchor()
                    if let realityFile = ArEntities[self.SelectedType]{
                        do{
                            switch self.SelectedType {
                            case .Jugar:
                                arLoader.loadRealityComposerSceneAsync(filePath:realityFile.FilePath!, sceneName: realityFile.SceneName!){ [self]
                                    result in
                                    switch result{
                                    case .success(let anchor):
                                        
                                        let model = anchor as! HasAnchoring // se convierte el anchor en un AnchorEntity
                                        let claroGame = ClaroGameAREntity()// se crea el ClaroGame AR
                                        claroGame.anchoring = model.anchoring // se copian los elentos del AnchorEntity
                                        claroGame.addChild(model)
                                        // instancia los eventos de juego
                                        claroGame.actions.claroShopGameAddScore.onAction = handleAddScore(_:)
                                        claroGame.actions.claroShopGameSubtractScore.onAction = handleSubstractScore(_:)
                                        claroGame.actions.claroShopGameStart.onAction = handleGameStart(_:)
                                        claroGame.actions.claroShopGameOver.onAction = handleGameOver(_:)
                                        claroGame.actions.claroShopGameNextLevel.onAction = handleNextLevel(_:)
                                        claroGame.actions.claroShopGameInstace.onAction = handleHasInstance(_:)
                                        claroGame.generateCollisionShapes(recursive: false)
                                        //claroGame.synchronization = nil
                                        self.ActiveEntity = claroGame
                                        uiView.scene.anchors.append(claroGame)
                                        //sleep(1)
                                        self.HasSelectedItem = false
                                        self.hasFinishedShowFile = true
                                        //CanEnableCanShow = true
                                        self.CanShowHelp = true
                                        self.IsSearching = true
                                     case .failure(let error):
                                         print("DEBUG ERROR: \(error.localizedDescription)")
                                         break
                                    }
                                    
                                }
                                
                            case .Escanear:
                                arLoader.loadRealityComposerSceneAsync(filePath:realityFile.FilePath!, sceneName: realityFile.SceneName!){ [self]
                                    result in
                                
                                    switch result{
                                    case .success(let anchor):
                                        
                                        let model = anchor as! HasAnchoring
                                        model.generateCollisionShapes(recursive: false)
                                        
                                        let claroDiscover = ClaroDiscoverAREntity()// se crea el ClaroGame AR
                                        claroDiscover.anchoring = model.anchoring
                                        claroDiscover.addChild(model)
                                        claroDiscover.generateCollisionShapes(recursive: false)
                                        claroDiscover.actions.claroShopGameInstace.onAction = handleHasInstance(_:)
                                        self.ActiveEntity = claroDiscover
                                        claroDiscover.synchronization = nil
                                        uiView.scene.anchors.append(claroDiscover)
                                        //sleep(1)
                                        self.HasSelectedItem = false
                                        self.hasFinishedShowFile = true
                                        //CanEnableCanShow = false
                                        self.CanShowHelp = true
                                        self.IsSearching = true
                                    case .failure(let error):
                                         print("DEBUG ERROR: \(error.localizedDescription)")
                                         break
                                    }
                                }
                                
                            case  .Conocer:
                                arLoader.loadRealityComposerSceneAsync(filePath:realityFile.FilePath!, sceneName: realityFile.SceneName!){ [self]
                                    result in
                                
                                    switch result{
                                    case .success(let anchor):
                                        
                                        let model = anchor as! HasAnchoring
                                        model.generateCollisionShapes(recursive: false)
                                        
                                        let claroDiscover = ClaroDiscoverAREntity()// se crea el ClaroGame AR
                                        claroDiscover.anchoring = model.anchoring
                                        claroDiscover.addChild(model)
                                        claroDiscover.generateCollisionShapes(recursive: false)
                                        claroDiscover.actions.claroShopGameInstace.onAction = handleHasInstance(_:)
                                        claroDiscover.synchronization = nil
                                        self.ActiveEntity = claroDiscover
                                        
                                        uiView.scene.anchors.append(claroDiscover)
                                        
                                        //sleep(1)
                                        self.HasSelectedItem = false
                                        self.hasFinishedShowFile = true
                                        //CanEnableCanShow = false
                                        self.CanShowHelp = true
                                        self.IsSearching = true
                                    case .failure(let error):
                                         print("DEBUG ERROR: \(error.localizedDescription)")
                                         break
                                    }
                                }
                            
                            default:
                                print("Invalid type")
                            }
                            
                        }catch{
                            print("DEBUG ERROR: No se crear ArEntity")
                        }
                    }

                }
            }
        }
        
    }
}
@available(iOS 13.0, *)
extension ClaroARViewContainer{
    func DeleteAnchor(){
        
        if let pastModel = self.ActiveEntity{
            if let anchorEntity = pastModel.anchor{
                anchorEntity.removeFromParent()
            }
        }
    }
    
    func handleHasInstance(_ entity: Entity?) {
        self.IsSearching = false
    }
    
}
@available(iOS 13.0, *)
extension ClaroARViewContainer{
    func handleGameStart(_ entity: Entity?) {
        self.Score = 0
        do {
            (self.ActiveEntity as! ClaroGameAREntity).notifications.claroShopGameStart.post()
        }
        catch {
            print("DEBUG ERROR: No s epudo parsear a tipo juego")
        }
        
    }
    
    func handleNextLevel(_ entity: Entity?) {
        do {
            (self.ActiveEntity as! ClaroGameAREntity).notifications.claroShopGameNextLevel.post()
        }
        catch {
            print("DEBUG ERROR: No s epudo parsear a tipo juego")
        }
        
    }
    
    func handleGameOver(_ entity: Entity?) {
        //Score = 0
        do {
            (self.ActiveEntity as! ClaroGameAREntity).notifications.claroShopGameOver.post()
        }
        catch {
            print("DEBUG ERROR: No s epudo parsear a tipo juego")
        }
    }
}

///Handle Score
@available(iOS 13.0, *)
extension ClaroARViewContainer{
    func handleAddScore(_ entity: Entity?) {
        AddScore()
    }
    
    func handleSubstractScore(_ entity: Entity?) {
        SubstractScore()
    }
    
    func AddScore() {
        self.Score += Int.random(in: 1..<3)
        print("Score: \(self.Score)")
    }
    
    func SubstractScore() {
        self.Score -= Int.random(in: 2..<4)
        print("Score: \(self.Score)")
        if self.Score <= 0{
            do {
                self.Score = 0
                (self.ActiveEntity as! ClaroGameAREntity).notifications.claroShopGameOver.post()
            }
            catch {
                print("DEBUG ERROR: No s epudo parsear a tipo juego")
            }

        }
    }
}



