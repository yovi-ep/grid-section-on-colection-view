//
//  MenuCV.swift
//  GridSection
//
//  Created by siemo on 12/01/20.
//  Copyright © 2020 siemo. All rights reserved.
//

import Foundation
import UIKit

class MenuCV: BaseCollectionGenericView {
    let mediator = MenuMediator(columnCount: 4)
    let headerMediator =  MenuHeaderMediator()

    let menu: [Any] = [
        MenuItem(icon: "ic_telkom", title: "Rekening"),
        MenuItem(icon: "ic_telkom", title: "Transfer"),
        MenuItem(icon: "ic_telkom", title: "Payment"),
        MenuItem(icon: "ic_telkom", title: "Purchase"),
        MenuItem(icon: "ic_telkom", title: "Cardless"),
        MenuItem(icon: "ic_telkom", title: "Purchase"),
        MenuItem(icon: "ic_telkom", title: "Cardless"),
        MenuItem(icon: "ic_telkom", title: "Purchase")
        
    ]
    
    override func initView() {
        super.initView()
        register(header: headerMediator)
        register(cell: mediator)
        
        setData(listOf: [
            SectionData(cells: menu, header: "Header"),
            SectionData(cells: menu, header: "Header 2"),
            SectionData(cells: menu, header: "Header 3")
        ])
    }
}
