//
//  MenuMediator.swift
//  GridSection
//
//  Created by siemo on 12/01/20.
//  Copyright © 2020 siemo. All rights reserved.
//

import Foundation
import UIKit

class MenuMediator: BaseCollectionMediatorCell<MenuCell, MenuItem> {
    var onTapClosure: ((_ data: MenuItem?) -> Void)?
    
    init(columnCount: CGFloat = 1) {
        super.init(dataType: MenuItem.self, columnCount: columnCount)
    }
    
    override func onCreateView(parent view: UICollectionViewCell) -> MenuCell {
        let child = MenuCell()
        return child
    }
    
    override func getHeight() -> Int {
        return 120
    }
    
    override func onBindView(parent: UICollectionViewCell, view: MenuCell, data: MenuItem) {
        view.setTitle(title: data.title, icon: data.icon)
        view.tappable { [weak self] (_) in
            self?.onTapClosure?(data)
        }
    }
}
