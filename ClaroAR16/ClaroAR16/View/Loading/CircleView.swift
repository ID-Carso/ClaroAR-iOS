//
//  CircleView.swift
//  Integracion11
//
//  Created by Yas Hernandez on 22/04/21.
//

import SwiftUI
@available(iOS 13.0, *)
struct CircleView: View {
    @State var delay: Double = 0 // 1.
        @State var scale: CGFloat = 0.5
    @State var transparency: Double = 0.5
        var body: some View {
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(Color.orange.opacity(transparency))
                .scaleEffect(scale)
                .animation(Animation.easeInOut(duration: 0.6).repeatForever().delay(delay)) // 2.
                .onAppear {
                    withAnimation {
                        self.scale = 1
                        self.transparency = 1
                    }
                }
        }
}


