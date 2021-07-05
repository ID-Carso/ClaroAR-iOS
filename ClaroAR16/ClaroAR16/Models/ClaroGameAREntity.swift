//
//  ClaroGameAREntity.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import RealityKit
/**
 Clase que modela el contenido de RA de tipo Escanear, contiene el evento para ocultar el marcador de buscando
 */
@available(iOS 13.0, *)
class ClaroDiscoverAREntity: Entity, RealityKit.HasAnchoring, RealityKit.HasCollision{
    public private(set) lazy var actions = ClaroDiscoverAREntity.Actions(root: self)

    public class Actions {

        fileprivate init(root: RealityKit.Entity) {
            self.root = root
        }

        private weak var root: RealityKit.Entity?

        public private(set) lazy var claroShopGameInstace = ClaroDiscoverAREntity.NotifyAction(identifier: "claroShopGameInstace", root: root)

        public private(set) lazy var allActions = [ claroShopGameInstace ]

    }
    
    public class NotifyAction {

        public let identifier: Swift.String

        public var onAction: ((RealityKit.Entity?) -> Swift.Void)?

        private weak var root: RealityKit.Entity?

        fileprivate init(identifier: Swift.String, root: RealityKit.Entity?) {
            self.identifier = identifier
            self.root = root

            Foundation.NotificationCenter.default.addObserver(self, selector: #selector(actionDidFire(notification:)), name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotifyAction"), object: nil)
        }

        deinit {
            Foundation.NotificationCenter.default.removeObserver(self, name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotifyAction"), object: nil)
        }

        @objc
        private func actionDidFire(notification: Foundation.Notification) {
            guard let onAction = onAction else {
                return
            }

            guard let userInfo = notification.userInfo as? [Swift.String: Any] else {
                return
            }

            guard let scene = userInfo["RealityKit.NotifyAction.Scene"] as? RealityKit.Scene,
                root?.scene == scene else {
                    return
            }

            guard let identifier = userInfo["RealityKit.NotifyAction.Identifier"] as? Swift.String,
                identifier == self.identifier else {
                    return
            }

            let entity = userInfo["RealityKit.NotifyAction.Entity"] as? RealityKit.Entity

            onAction(entity)
        }

    }
}

/**
    Clase que modela el contenido RA de juegar, contiene las NotifyActions  y NotificationTrigger para gestionar los eventos de actualizar Score, start game y game over
 */
@available(iOS 13.0, *)
class ClaroGameAREntity: Entity, RealityKit.HasAnchoring  {
    public class NotifyAction {

        public let identifier: Swift.String

        public var onAction: ((RealityKit.Entity?) -> Swift.Void)?

        private weak var root: RealityKit.Entity?

        fileprivate init(identifier: Swift.String, root: RealityKit.Entity?) {
            self.identifier = identifier
            self.root = root

            Foundation.NotificationCenter.default.addObserver(self, selector: #selector(actionDidFire(notification:)), name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotifyAction"), object: nil)
        }

        deinit {
            Foundation.NotificationCenter.default.removeObserver(self, name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotifyAction"), object: nil)
        }

        @objc
        private func actionDidFire(notification: Foundation.Notification) {
            guard let onAction = onAction else {
                return
            }

            guard let userInfo = notification.userInfo as? [Swift.String: Any] else {
                return
            }

            guard let scene = userInfo["RealityKit.NotifyAction.Scene"] as? RealityKit.Scene,
                root?.scene == scene else {
                    return
            }

            guard let identifier = userInfo["RealityKit.NotifyAction.Identifier"] as? Swift.String,
                identifier == self.identifier else {
                    return
            }

            let entity = userInfo["RealityKit.NotifyAction.Entity"] as? RealityKit.Entity

            onAction(entity)
        }

    }
    
    public class NotificationTrigger {

        public let identifier: Swift.String

        private weak var root: RealityKit.Entity?

        fileprivate init(identifier: Swift.String, root: RealityKit.Entity?) {
            self.identifier = identifier
            self.root = root
        }

        public func post(overrides: [Swift.String: RealityKit.Entity]? = nil) {
            guard let scene = root?.scene else {
                print("Unable to post notification trigger with identifier \"\(self.identifier)\" because the root is not part of a scene")
                return
            }

            var userInfo: [Swift.String: Any] = [
                "RealityKit.NotificationTrigger.Scene": scene,
                "RealityKit.NotificationTrigger.Identifier": self.identifier
            ]
            userInfo["RealityKit.NotificationTrigger.Overrides"] = overrides

            Foundation.NotificationCenter.default.post(name: Foundation.NSNotification.Name(rawValue: "RealityKit.NotificationTrigger"), object: self, userInfo: userInfo)
        }

    }

    
    public private(set) lazy var actions = ClaroGameAREntity.Actions(root: self)
    public private(set) lazy var notifications = ClaroGameAREntity.Notifications(root: self)

    public class Notifications {

        fileprivate init(root: RealityKit.Entity) {
            self.root = root
        }

        private weak var root: RealityKit.Entity?

        public private(set) lazy var claroShopGameNextLevel = ClaroGameAREntity.NotificationTrigger(identifier: "ClaroShop_Game_NextLevel", root: root)
        public private(set) lazy var claroShopGameOver = ClaroGameAREntity.NotificationTrigger(identifier: "ClaroShop_Game_Over", root: root)
        public private(set) lazy var claroShopGameStart = ClaroGameAREntity.NotificationTrigger(identifier: "ClaroShop_Game_Start", root: root)

        public private(set) lazy var allNotifications = [ claroShopGameStart, claroShopGameOver, claroShopGameNextLevel ]

    }

    public class Actions {

        fileprivate init(root: RealityKit.Entity) {
            self.root = root
        }

        private weak var root: RealityKit.Entity?

        public private(set) lazy var claroShopGameAddScore = ClaroGameAREntity.NotifyAction(identifier: "ClaroShop_Game_AddScore", root: root)
        public private(set) lazy var claroShopGameNextLevel = ClaroGameAREntity.NotifyAction(identifier: "ClaroShop_Game_NextLevel", root: root)
        public private(set) lazy var claroShopGameOver = ClaroGameAREntity.NotifyAction(identifier: "ClaroShop_Game_Over", root: root)
        public private(set) lazy var claroShopGameStart = ClaroGameAREntity.NotifyAction(identifier: "ClaroShop_Game_Start", root: root)
        public private(set) lazy var claroShopGameInstace = ClaroGameAREntity.NotifyAction(identifier: "claroShopGameInstace", root: root)
        public private(set) lazy var claroShopGameSubtractScore = ClaroGameAREntity.NotifyAction(identifier: "ClaroShop_Game_SubtractScore", root: root)

        public private(set) lazy var allActions = [ claroShopGameStart, claroShopGameAddScore, claroShopGameOver, claroShopGameSubtractScore, claroShopGameNextLevel, claroShopGameInstace ]

    }
}


