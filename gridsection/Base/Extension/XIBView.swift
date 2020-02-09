//
//  XIBView.swift
//  BBADigitalBanking
//
//  Created by Avendi Timbul Sianipar on 05/11/19.
//  Copyright © 2019 Multipolar. All rights reserved.
//

import UIKit

class XIBView: TappableView {
    var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
}

extension XIBView {
    @objc dynamic func initView() {}
}

private extension XIBView {
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.backgroundColor = UIColor.clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        backgroundColor = UIColor.clear
        addSubview(view)
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[childView]|",
                                                      options: [],
                                                      metrics: nil,
                                                      views: ["childView": view!]))
        initView()
    }
    
    func loadViewFromNib() -> UIView! {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
}
