//
//  HostCtrl.swift
//  ClaroAR16
//
//  Created by Yas Hernandez on 10/08/21.
//

import Foundation

final class HostCtrl: UIHostingController<SettingsView> {
    required init?(coder: NSCoder) {
        super.init(coder: coder, rootView: SettingsView())
        rootView.dismiss = dismiss
    }

    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
