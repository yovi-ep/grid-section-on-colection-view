//
//  MenuCell.swift
//  GridSection
//
//  Created by siemo on 12/01/20.
//  Copyright © 2020 siemo. All rights reserved.
//

import UIKit

class MenuCell: XIBView {

    @IBOutlet weak var tvTitle: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    
    func setTitle(title: String, icon: String) {
        tvTitle.text = title
        imgIcon.image = UIImage(named: icon)
    }
}
