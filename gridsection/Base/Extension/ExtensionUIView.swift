//
//  ExtensionUIView.swift
//  BBADigitalBanking
//
//  Created by Avendi Timbul Sianipar on 05/11/19.
//  Copyright © 2019 Multipolar. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // MARK: - XIB Loader
    func loadNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nibName = type(of: self).description().components(separatedBy: ".").last!
        let nib = UINib(nibName: nibName, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as! UIView
    }
    
    // MARK: - Subview
    func removeAll() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
    
    func toggleSubview(isShow: Bool) {
        for subview in subviews {
            subview.isHidden = !isShow
            subview.toggleSubview(isShow: isShow)
        }
    }
    
    func showAllSubviews() {
        isHidden = false
        for subview in subviews {
            subview.isHidden = false
            subview.showAllSubviews()
        }
    }
    
    func hideSubviewsWith(selfView: Bool, container: Bool) {
        if selfView {
            isHidden = true
        }
        for subview in subviews {
            if subview.subviews.isEmpty {
                subview.isHidden = true
            } else {
                subview.hideSubviewsWith(selfView: container, container: container)
            }
        }
    }

    func getFirstResponder() -> UIView? {
        for subView in subviews {
            if subView.isFirstResponder {
                return subView
            }

            if let recursiveSubView = subView.getFirstResponder() {
                return recursiveSubView
            }
        }

        return nil
    }

    func getCoordinatesInSuperview() -> CGRect? {
        if let viewController = getViewController() {
            if let view = viewController.view {
                return convert(frame, to: view)
            }
        }
        return nil
    }
    
    // MARK: - Gesture
    func tap(_ tapGestureRecognizer: UITapGestureRecognizer) -> Void {
        isUserInteractionEnabled = true
        gestureRecognizers?.removeAll()
        addGestureRecognizer(tapGestureRecognizer)
    }
    
    // MARK: - Constraint
    func addSubviewWithConstraint(item: UIView, top: CGFloat? = nil, leading: CGFloat? = nil, bottom: CGFloat? = nil, trailing: CGFloat? = nil) {
        item.translatesAutoresizingMaskIntoConstraints = false
        addSubview(item)
        if let top = top {
            item.addTopConstraint(to: self, constant: top)
        }
        if let bottom = bottom {
            item.addBottomConstraint(to: self, constant: bottom * -1)
        }
        if let leading = leading {
            item.addLeadingConstraint(to: self, constant: leading)
        }
        if let trailing = trailing {
            item.addTrailingConstraint(to: self, constant: trailing * -1)
        }
    }

    func addSubviewWithConstraint(item: UIView, spacing: CGFloat) {
        addSubviewWithConstraint(item: item, top: spacing, leading: spacing, bottom: spacing, trailing: spacing)
    }

    func addSubviewCenterConstraint(item: UIView) {
        item.translatesAutoresizingMaskIntoConstraints = false
        addSubview(item)

        addCenterXConstraint(to: item)
        addCenterYConstraint(to: item)
    }

    func addCenterXConstraint(to item: UIView) {
        centerXAnchor.constraint(equalTo: item.centerXAnchor).isActive = true
    }

    func addCenterYConstraint(to item: UIView) {
        centerYAnchor.constraint(equalTo: item.centerYAnchor).isActive = true
    }

    func addTopConstraint(to item: UIView, constant: CGFloat) {
        topAnchor.constraint(equalTo: item.topAnchor, constant: constant).isActive = true
    }

    func addBottomConstraint(to item: UIView, constant: CGFloat, priority: Float = 1000) {
        let temp = bottomAnchor.constraint(equalTo: item.bottomAnchor, constant: constant)
        temp.priority = UILayoutPriority(rawValue: priority)
        temp.isActive = true
    }

    func addLeadingConstraint(to item: UIView, constant: CGFloat, priority: Float = 1000) {
        let temp = leadingAnchor.constraint(equalTo: item.leadingAnchor, constant: constant)
        temp.priority = UILayoutPriority(rawValue: priority)
        temp.isActive = true
    }

    func addTrailingConstraint(to item: UIView, constant: CGFloat) {
        trailingAnchor.constraint(equalTo: item.trailingAnchor, constant: constant).isActive = true
    }

    func addHeightConstraint(_ constant: CGFloat) {
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func addWidthConstraint(_ constant: CGFloat) {
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }

    func getConstraint(identifier: String) -> NSLayoutConstraint? {
        for constraint in constraints {
            if constraint.identifier == identifier {
                return constraint
            }
        }
        return nil
    }
    
    func getConstraint(firstAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        for constraint in constraints {
            if constraint.firstAttribute == firstAttribute {
                return constraint
            }
        }
        return nil
    }
    
    func getHeightConstraint() -> NSLayoutConstraint? {
        return getConstraint(firstAttribute: .height)
    }
    
    func getWidthConstraint() -> NSLayoutConstraint? {
        return getConstraint(firstAttribute: .width)
    }
    
    func getBottomConstraint() -> NSLayoutConstraint? {
        return getConstraint(firstAttribute: .bottom)
    }
    
    // MARK: - Layer
    func setToCircle() {
        layer.cornerRadius = frame.width / 2.0
        clipsToBounds = true
    }
    
    func setRadius(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }

    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func addDashedLayer(strokeColor: UIColor, dashedFrame: CGRect? = nil) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = strokeColor.cgColor
        borderLayer.lineDashPattern = [3, 3]
        borderLayer.frame = dashedFrame ?? bounds
        borderLayer.fillColor = nil
        borderLayer.path = UIBezierPath(rect: dashedFrame ?? bounds).cgPath
        layer.addSublayer(borderLayer)
    }
    
    func addDashedLine(strokeColor: UIColor, start p0: CGPoint, end p1: CGPoint) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [3, 3]
            
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        layer.addSublayer(shapeLayer)
    }
    
    func removeAllSublayer() {
        layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }
    
    // MARK: - Animation
    func animateX(x: CGFloat, completion: ((Bool) -> Void)?) {
        animate(animations: { self.frame.origin.x = x }, completion: completion)
    }
    
    func animateY(y: CGFloat, completion: ((Bool) -> Void)?) {
        animate(animations: { self.frame.origin.y = y }, completion: completion)
    }
    
    func animate(animations: @escaping () -> Void, completion: ((Bool) -> Void)?) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0.0,
            options: .curveLinear,
            animations: animations,
            completion: completion
        )
    }
    
    // MARK: - Shadow
    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
    
    func addBottomShadow(color: UIColor = .black, opacity: Float = 0.5, radius: CGFloat = 5.0, shadowSize: CGSize) {
        addShadow(offset: CGSize.zero, color: color, opacity: opacity, radius: radius)
        let shadowPath = UIBezierPath()
        shadowPath.move(to: CGPoint(x: 0, y: shadowSize.height))
        shadowPath.addLine(to: CGPoint(x: shadowSize.width, y: shadowSize.height))
        shadowPath.addLine(to: CGPoint(x: shadowSize.width, y: shadowSize.height + radius))
        shadowPath.addLine(to: CGPoint(x: 0, y: shadowSize.height + radius))
        shadowPath.close()

        layer.shadowPath = shadowPath.cgPath
    }
    
    func addDefaultShadow() {
        //addShadow(offset: CGSize(width: 0, height: 0), color: Color.default, opacity: 0.06, radius: 1)
    }
    
    // MARK: - Frame
    func setFrameHeight(height: CGFloat) {
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.width, height: height)
    }
    
    func setFrameWidth(width: CGFloat) {
        frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: width, height: frame.height)
    }

    func getViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.getViewController()
        } else {
            return nil
        }
    }
    
    func findView(identifier: String) -> UIView? {
        if self.accessibilityIdentifier == identifier {
            return self
        }
        
        for view in subviews {
            if let view = view.findView(identifier: identifier) {
                return view
            }
        }
        
        return nil
    }
    
    func add(child view: UIView, withTag tag: Int = 1) {
        if (viewWithTag(tag) != nil) {
            return
        }
        
        view.tag = tag
        addSubviewWithConstraint(item: view, spacing: 0)
    }
}
