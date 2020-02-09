//
//  MenuHeaderCell.swift
//  GridSection
//
//  Created by siemo on 12/01/20.
//  Copyright © 2020 siemo. All rights reserved.
//

import UIKit

class MenuHeaderCell: XIBView {
    @IBOutlet weak var tvTitle: UILabel!
    func setTitle(title: String) {
        tvTitle.text = title
    }
}
