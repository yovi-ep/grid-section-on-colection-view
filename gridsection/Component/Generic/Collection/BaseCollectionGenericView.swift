//
//  BaseCollectionGenericView.swift
//  BBADigitalBanking
//
//  Created by Avendi Timbul Sianipar on 15/11/19.
//  Copyright © 2019 Multipolar. All rights reserved.
//

import UIKit

class BaseCollectionGenericView: UICollectionView {
    private var listMediator = [BaseMediator]()
    private var listMediatorHeader = [BaseMediator]()
    private var listMediatorFooter = [BaseMediator]()
    
    private var data = [SectionData]()
    
    private var paddingSize:CGFloat = 16
    
    struct KIND {
        static let HEADER = "UICollectionElementKindSectionHeader"
        static let FOOTER = "UICollectionElementKindSectionFooter"
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initView()
    }
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initView()
    }
    
    func initView(){
        dataSource = self
        delegate = self
    }
    
    func register(cell mediator: BaseMediator) {
        listMediator.append(mediator)
        register(UICollectionViewCell.self, forCellWithReuseIdentifier: mediator.identifier)
    }
    
    func register(header mediator: BaseMediator) {
        listMediatorHeader.append(mediator)
        register(UICollectionReusableView.self, forSupplementaryViewOfKind: KIND.HEADER, withReuseIdentifier: mediator.identifier)
    }
    
    func register(footer mediator: BaseMediator) {
        listMediatorFooter.append(mediator)
        register(UICollectionReusableView.self, forSupplementaryViewOfKind: KIND.FOOTER, withReuseIdentifier: mediator.identifier)
    }
    
    func setData(listOf sections: [SectionData]) {
        data = sections
    }
    
    func setData(listOf any: [Any]) {
        data = [SectionData(cells: any)]
    }
    
    func setPadding(size: CGFloat) {
        paddingSize = size
    }
}

extension BaseCollectionGenericView: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].cells.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let newData = data[indexPath.section].cells[indexPath.row]
        let mediator = getMediator(typeOf: newData)
        
        let cell = dequeueReusableCell(withReuseIdentifier: mediator.identifier, for: indexPath)
        cell.add(child: mediator.createView(parent: cell))
        
        if let child = cell.viewWithTag(1) {
            mediator.bindView(parent: cell, view: child, data: newData)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        guard let newData = data[indexPath.section].header else {
            return UICollectionReusableView()
        }
        
        switch kind {
        case KIND.HEADER:
            let mediator = getMediatorHeader(typeOf: newData)
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mediator.identifier, for: indexPath)
            
            header.add(child: mediator.createView(parent: header))
            
            if let child = header.viewWithTag(1) {
                mediator.bindView(parent: header, view: child, data: newData)
            }
            
            return header
        case KIND.FOOTER:
            let mediator = getMediatorFooter(typeOf: newData)
            let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: mediator.identifier, for: indexPath)
            
            footer.add(child: mediator.createView(parent: footer))
            
            if let child = footer.viewWithTag(1) {
                mediator.bindView(parent: footer, view: child, data: newData)
            }
            
            return footer
        default:
            assert(false, "Invalid element type")
        }
        
        return UICollectionReusableView()
    }
}

extension BaseCollectionGenericView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        let newData = data[indexPath.section].cells[indexPath.row]
        let mediator = getMediator(typeOf: newData)
        return getSize(for: mediator)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int
    ) -> CGSize {
        guard let newData = data[section].header else {
            return CGSize(width: collectionView.frame.width, height: 0.0)
        }
        
        let mediator = getMediatorHeader(typeOf: newData)
        return getSize(for: mediator)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForFooterInSection section: Int
    ) -> CGSize {
        guard let newData = data[section].footer else {
            return CGSize(width: collectionView.frame.width, height: 0.0)
        }
        
        let mediator = getMediatorFooter(typeOf: newData)
        return getSize(for: mediator)
    }
    
    private func getSize(for mediator: BaseMediator) -> CGSize {
        let padding = paddingSize * (mediator.columnCount + 1)
        let availableWidth = frame.width - padding
        
        let width = Int(availableWidth / mediator.columnCount)
        var height = mediator.getHeight()
        if height == -1 {
            height = width
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets(top: paddingSize, left: paddingSize, bottom: paddingSize, right: paddingSize)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return paddingSize
    }
}

private extension BaseCollectionGenericView{
    func getMediator(typeOf data: Any) -> BaseMediator {
        return getMediator(for: listMediator, typeOf: data)
    }
    
    func getMediatorHeader(typeOf data: Any) -> BaseMediator {
        return getMediator(for: listMediatorHeader, typeOf: data)
    }
    
    func getMediatorFooter(typeOf data: Any) -> BaseMediator {
        return getMediator(for: listMediatorFooter, typeOf: data)
    }
    
    private func getMediator(for listMediator: [BaseMediator], typeOf data: Any) -> BaseMediator {
        guard let mediator = listMediator.first(where: { mediator in "\(mediator.identifier)" == "\(type(of: data))"}) else {
            fatalError("no mediator for \(type(of: data))")
        }
        
        return mediator
    }
}
