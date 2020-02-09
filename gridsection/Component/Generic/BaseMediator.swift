//
//  BaseMediator.swift
//  BBADigitalBanking
//
//  Created by Avendi Timbul Sianipar on 15/11/19.
//  Copyright © 2019 Multipolar. All rights reserved.
//

import Foundation
import UIKit

class BaseMediator {
    let identifier: String
    let columnCount: CGFloat
    
    init(dataType: Any, columnCount: CGFloat = 1) {
        self.identifier = "\(dataType)"
        self.columnCount = columnCount
    }
    
    func createView(parent view: UIView) -> UIView {
        fatalError("no view")
    }
    
    func getHeight() -> Int {
        return -1
    }
    
    func bindView(parent: UIView, view: UIView, data: Any) {}
}
