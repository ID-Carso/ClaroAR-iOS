//
//  TutorialVideoView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 25/03/21.
//

import Foundation
import AVKit
import AVFoundation
import SwiftUI

/**
 Vista para el video del tutorial de inicio
 */
@available(iOS 13.0, *)
struct TutorialVideo: UIViewRepresentable {
    @Binding var hasFinishedVideo: Bool
    @ObservedObject var player: PlayerUIView
    
    func makeUIView(context: Context) -> PlayerUIView {
        
        return player
    }
    
    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        DispatchQueue.main.async {
            
            self.hasFinishedVideo = player.hasFinishedVideo
            
            
        }
    }
}
/**
 Vista que reproduce el video del tutorial por contenido
 */
@available(iOS 13.0, *)
struct TutorialVideoHelp: UIViewRepresentable {
    @Binding var helpType: HelpView.HelpType
    @ObservedObject var player: PlayerUIView
    func makeUIView(context: Context) -> PlayerUIView {
        
        return player
    }
    
    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        DispatchQueue.main.async {
            
            if player.hasFinishedVideo
            {
                self.helpType = .General
            }
        }
    }
}

/**
 Clase que almacena el reproductor de video y asigna un evento para notifica@availabler que el video ha termiando su reproduccion
 */
@available(iOS 13.0, *)
class PlayerUIView: UIView, ObservableObject{
    private var playerLayer = AVPlayerLayer()
    public var player: AVPlayer?
    @Published var hasFinishedVideo: Bool = false
    
    init(frame: CGRect, url: URL){
        super.init(frame: frame)
        hasFinishedVideo = false
        do{
            let playeritem = AVPlayerItem(url: url)
            
            player = try AVPlayer(playerItem: playeritem)
            if player != nil{
                playerLayer.player = player
                playerLayer.videoGravity = .resizeAspectFill
                layer.addSublayer(playerLayer)
                player?
                    .actionAtItemEnd = .pause
                
               
                NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
                player?.play()
            }
            else{
                self.hasFinishedVideo = true
            }
        }
        catch{
            self.hasFinishedVideo = true
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds
    }
    required init(coder: NSCoder) {
        fatalError("init(doer:) fail")
    }
    
    @objc func playerDidFinishPlaying(sender: Notification) {
        self.hasFinishedVideo = true
        print("DEBUG: Video finished \(self.hasFinishedVideo)")
        
        
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self)
    }
}
