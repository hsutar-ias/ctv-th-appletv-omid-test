//
//  BaseAdViewController.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 18/07/23.
//

import Foundation
import UIKit
/**
 - BaseAdViewController class extends UIViewController and Menu extensions(ReloadAdOptionInViewController, InfoOptionInViewController and LogOptionInViewController )
 - This class is used as a base class for Simple, Obstruction, Scrolling, Clipped, Clutter, Tabbed classes
 - Configure all functions which are used in all subclasses
 */
class BaseAdViewController: UIViewController, ReloadAdOptionInViewController, LogOptionInViewController {
    private var titleLabel : UILabel?
    private var parentView: UIView?
    private var topConstraint: NSLayoutConstraint?
    private var leftConstraint : NSLayoutConstraint?
    private var topHiddenConstraint : NSLayoutConstraint?
    private var leftHiddenConstraint : NSLayoutConstraint?
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        NotificationCenter.default.addObserver(self, selector: Selector(("observeVisibilityNotification:")), name: NSNotification.Name(rawValue: THBaseWebViewHolder.VISIBILITY_NOTIFICATION), object: nil)
        updateVisibilityTitle()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if (parentView != nil) {
//            updatePositionConstraints()
        }
    }
    
    @objc func observeVisibilityNotification(_ notification: Notification?) {
        updateVisibilityTitle()
    }
    
    func updateVisibilityTitle() {
        setVisibilityTitle(adVisibilityString())
    }
    
    
    @objc func reloadAd() {
        clear()
        create()
    }
    
    @objc func showAppLogs() {
        showLogs()
    }
    
    func create() {
        
    }
    
    func clear() {
//        AppLog.sharedLog.clear()
        self.setVisibilityTitle(self.adVisibilityString())
    }
    
    func setVisibilityTitle(_ visibility: String?) {
        let str = NSMutableAttributedString(string: navigationItem.title ?? "")
        str.addAttribute(.font, value: UIFont.boldSystemFont(ofSize: 17), range: NSRange(location: 0, length: str.length))
        if let visibility = visibility {
            let str1 = NSMutableAttributedString(string: "\n\(visibility)")
            str1.addAttribute(.font, value: UIFont.systemFont(ofSize: 13), range: NSRange(location: 0, length: str1.length))
            str.append(str1)
        }
        let style = NSMutableParagraphStyle()
        style.alignment = .center
        style.lineHeightMultiple = 0.9
        style.lineBreakMode = .byTruncatingTail
        str.addAttribute(.paragraphStyle, value: style, range: NSRange(location: 0, length: str.length))
        titleLabel!.attributedText = str
        let size = titleLabel!.sizeThatFits(CGSize(width: 10000, height: 10000))
        titleLabel!.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
    }
    func adVisibilityString() -> String? {
        return nil
    }
    
    //MARK: Layout Constraints
    
    func verticalAttributeForAdPosition() -> NSLayoutConstraint.Attribute{
        return NSLayoutConstraint.Attribute.top
    }
    
  
    func setSize(toAdView adView: UIView?, containerView: UIView?) {
//        if size.width == 0 {
//            addConstraint(NSLayoutConstraint.Attribute.width, to: containerView, subview: adView)
//        } else {
//            addSizeAttirbute(NSLayoutConstraint.Attribute.width, to: adView, constant: size.width)
//        }
//        if size.height == 0 {
//            addConstraint(NSLayoutConstraint.Attribute.height, to: containerView, subview: adView)
//        } else {
//            addSizeAttirbute(NSLayoutConstraint.Attribute.height, to: adView, constant: size.height)
//        }
    }
    
    func addSizeAttirbute(_ attribute: NSLayoutConstraint.Attribute, to view: UIView?, constant: CGFloat) {
        if let view = view {
            view.addConstraint(
                NSLayoutConstraint(
                    item: view,
                    attribute: attribute,
                    relatedBy: .equal,
                    toItem: nil,
                    attribute: .notAnAttribute,
                    multiplier: 1,
                    constant: constant))
        }
    }
    
    func addConstraint(_ attribute: NSLayoutConstraint.Attribute, to view: UIView?, subview: UIView?, constant: CGFloat) {
        view?.addConstraint(toItem: subview, attribute: attribute, constant: constant)
    }
    
    func addConstraint(_ attribute: NSLayoutConstraint.Attribute, to view: UIView?, subview: UIView?) {
        addConstraint(attribute, to: view, subview: subview!, constant: 0)
    }
    
    func addConstraint(_ attribute: NSLayoutConstraint.Attribute, to view: UIView?, firstItem view1: UIView?, secondItem view2: UIView?) {
        view?.addConstraint(toItem: view1, attribute: attribute)
    }

    func setLayoutConstraintsForAdView(_ adView: UIView?, container: UIView?) {
        setSize(toAdView: adView, containerView: container)
        addConstraint(NSLayoutConstraint.Attribute.centerX, to: container, subview: adView)
        addConstraint(verticalAttributeForAdPosition(), to: container, subview: adView)
    }
//
//    func updatePositionConstraints() {
//        if let p = parentView?.window?.convert(Config.sharedConfig.customAdPosition, from: nil) {
//            let pConverted = parentView?.convert(p, from: nil)
//            leftConstraint?.constant = pConverted!.x
//            topConstraint?.constant = pConverted!.y
//        }
//    }
  
}
