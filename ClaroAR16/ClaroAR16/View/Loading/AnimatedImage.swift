//
//  AnimatedImage.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import Combine
import SwiftUI
@available(iOS 13.0, *)
class LoadingTimer {

    let publisher = Timer.publish(every: 2.0, on: .main, in: .default)
    var timerCancellable: Cancellable?

    func start() {
        self.timerCancellable = publisher.connect()
    }

    func cancel() {
        self.timerCancellable?.cancel()
    }
}
@available(iOS 13.0, *)
struct AnimatedImageTimer: View {

    @State var index = 0
    //public let ImagesTextName: [String]
    public let ImagesName: [String]
    var timer = LoadingTimer()

    var body: some View {

        return Image(ImagesName[index])
            .resizable()
            .scaledToFit()
            .onReceive(
                timer.publisher,
                perform: { _ in
                    self.index = self.index + 1
                    if self.index >= ImagesName.count { self.index = 0 }
                }
            )
            .onAppear { self.timer.start() }
            .onDisappear { self.timer.cancel() }
            
    }
}
