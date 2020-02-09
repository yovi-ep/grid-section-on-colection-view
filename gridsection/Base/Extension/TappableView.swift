//
//  TappableView.swift
//  BBADigitalBanking
//
//  Created by Avendi Timbul Sianipar on 15/11/19.
//  Copyright © 2019 Multipolar. All rights reserved.
//

import UIKit

typealias IntFunction = (_ value: Int) -> Void

class TappableView: UIView {

    var tappedHandler: IntFunction?
    var longPressHandler: IntFunction?
    
    func tappable(tappedHandler: @escaping IntFunction) {
        self.tappedHandler = tappedHandler
        tap(UITapGestureRecognizer(target: self, action: #selector(tappableSelector)))
    }
    
    func longPress(longPressHandler: @escaping IntFunction) {
        self.longPressHandler = longPressHandler
        addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(longPressSelector)))
    }
    
    @objc func tappableSelector(_ sender: Any){
        guard let recognizer = sender as? UITapGestureRecognizer else {
            return
        }
        
        guard let currentTag = recognizer.view?.tag else {
            return
        }
        
        tappedHandler?(currentTag)
    }
    
    @objc func longPressSelector(_ sender: Any){
        guard let recognizer = sender as? UILongPressGestureRecognizer else {
            return
        }
        
        guard let currentTag = recognizer.view?.tag else {
            return
        }
        
        longPressHandler?(currentTag)
    }
}
