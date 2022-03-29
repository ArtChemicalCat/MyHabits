//
//  UIView+Extension.swift
//  MyHabits
//
//  Created by Николай Казанин on 28.03.2022.
//

import UIKit

extension UIView {
    func fillParentView() {
        guard let parent = self.superview else { return }
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.topAnchor),
            self.trailingAnchor.constraint(equalTo: parent.trailingAnchor),
            self.leadingAnchor.constraint(equalTo: parent.leadingAnchor),
            self.bottomAnchor.constraint(equalTo: parent.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension UIView {
    static var id: String {
        String(describing: self)
    }
}
