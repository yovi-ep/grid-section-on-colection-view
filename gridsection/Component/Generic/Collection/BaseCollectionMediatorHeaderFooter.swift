//
//  BaseCollectionMediatorHeaderFooter.swift
//  BBADigitalBanking
//
//  Created by Avendi Timbul Sianipar on 15/11/19.
//  Copyright © 2019 Multipolar. All rights reserved.
//

import UIKit

class BaseCollectionMediatorHeaderFooter<VIEW: UIView, DATA> : BaseMediator{
    override func createView(parent view: UIView) -> UIView {
        if let parent = view as? UICollectionReusableView {
            return onCreateView(parent: parent)
        }
        fatalError("needed to ovveride")
    }
    
    override func bindView(parent: UIView, view: UIView, data: Any) {
        if let parent = parent as? UICollectionReusableView,
            let view = view as? VIEW,
            let data = data as? DATA {
            onBindView(parent: parent, view: view, data: data)
        }
    }
    
    func onCreateView(parent view: UICollectionReusableView) -> VIEW {
        fatalError("needed to ovveride")
    }
    
    func onBindView(parent: UICollectionReusableView, view: VIEW, data: DATA) {}
}
