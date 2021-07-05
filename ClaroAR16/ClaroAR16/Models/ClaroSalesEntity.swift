//
//  ClaroSalesEntity.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 17/03/21.
//

import Foundation
import RealityKit
@available(iOS 13.0, *)
class ClaroSalesEntity: Entity, RealityKit.HasAnchoring
{
    public private(set) lazy var actions = ClaroSalesEntity.Actions(root: self)
    
    public class Actions {

        fileprivate init(root: RealityKit.Entity) {
            self.root = root
        }

        private weak var root: RealityKit.Entity?

        
        public private(set) lazy var claroShopOpenSaleLink1 = ClaroSalesEntity.NotifyAction(identifier: "ClaroShop_Open_SaleLink1", root: root)
        public private(set) lazy var claroShopOpenSaleLink2 = ClaroSalesEntity.NotifyAction(identifier: "ClaroShop_Open_SaleLink2", root: root)
        public private(set) lazy var claroShopOpenSaleLink3 = ClaroSalesEntity.NotifyAction(identifier: "ClaroShop_Open_SaleLink3", root: root)


        public private(set) lazy var allActions = [claroShopOpenSaleLink1, claroShopOpenSaleLink2, claroShopOpenSaleLink3 ]

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
}
