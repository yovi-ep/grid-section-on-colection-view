//
//  ViewController.swift
//  gridsection
//
//  Created by siemo on 09/02/20.
//  Copyright © 2020 multipolar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var menuVC: MenuCV!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("startup")
        menuVC.backgroundColor = UIColor.clear
        menuVC.mediator.onTapClosure = { [weak self] (data) in
            print("asjhdkjashdkjashdjkashd")
        }
    }
}

