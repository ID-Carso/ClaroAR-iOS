//
//  AnimatedImagesView.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import UIKit
import SwiftUI
/**
 Vista que muestra una secuencia de imagenes
 */
@available(iOS 13.0, *)
struct AnimatedImagesView: UIViewRepresentable {
    let imageSize: CGSize
        let imageNames: [String]
        let duration: Double 

        func makeUIView(context: Self.Context) -> UIView {
            //let containerView = UIView(frame: CGRect())
            let containerView = UIView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            let animationImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: imageSize.width, height: imageSize.height))
            //let animationImageView = UIImageView(frame: CGRect())
            animationImageView.contentMode = .scaleAspectFit
            animationImageView.clipsToBounds = true
            animationImageView.layer.cornerRadius = 5
            animationImageView.autoresizesSubviews = true
            

            var images = [UIImage]()
            imageNames.forEach { imageName in
                if let img = UIImage(named: imageName) {
                    images.append(img)
                }
            }
            
            animationImageView.image = UIImage.animatedImage(with: images, duration: duration)

            containerView.addSubview(animationImageView)

            return containerView
        }

        func updateUIView(_ uiView: UIView, context: UIViewRepresentableContext<AnimatedImagesView>) {

        }
}


