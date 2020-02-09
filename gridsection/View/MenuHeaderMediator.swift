//
//  MenuHeaderMediator.swift
//  GridSection
//
//  Created by siemo on 12/01/20.
//  Copyright © 2020 siemo. All rights reserved.
//

import Foundation
import UIKit

class MenuHeaderMediator: BaseCollectionMediatorHeaderFooter<MenuHeaderCell, String> {
    
    init(columnCount: CGFloat = 1) {
        super.init(dataType: String.self, columnCount: columnCount)
    }
    
    override func onCreateView(parent view: UICollectionReusableView) -> MenuHeaderCell {
        return MenuHeaderCell()
    }
    
    override func onBindView(parent: UICollectionReusableView, view: MenuHeaderCell, data: String) {
        view.setTitle(title: data)
    }
    
    override func getHeight() -> Int {
        return 27
    }
}
