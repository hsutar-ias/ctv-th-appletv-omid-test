//
//  UIViewControllerUtil.swift
//  IAS Apple CTV Demo
//
//  Created by Archana Deshmukh on 18/07/23.
//

import Foundation
import UIKit
/**
 - UIViewControllerUtil class is used for creating a extensions for handlings toolbar menus and string functions
 */
protocol OptionMenuProtocol {
    func button(withImage imageName: String?, action: Selector) -> UIButton?
}

extension OptionMenuProtocol {
    func button(withImage imageName: String?, action: Selector) -> UIButton? {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
        button.setImage(UIImage(named: imageName ?? ""), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        return button
    }
}

// MARK: Log menu
protocol LogOptionInViewController: OptionMenuProtocol {
    func logsItem(withAction action: Selector) -> UIBarButtonItem?
}

extension LogOptionInViewController where Self : UIViewController{
    func logsItem(withAction action: Selector) -> UIBarButtonItem? {
        return UIBarButtonItem(customView: button(withImage: "Logs", action: action)!)
    }
    
    func showLogs() {
        let controller = storyboard?.instantiateViewController(withIdentifier: "LogsViewController")
        navigationController?.pushViewController(controller!, animated: true)
    }
}

// MARK: Info menu
protocol InfoOptionInViewController: OptionMenuProtocol {
    func infoItem(withAction action: Selector) -> UIBarButtonItem?
}

//extension InfoOptionInViewController where Self : UIViewController{
//    func infoItem(withAction action: Selector) -> UIBarButtonItem? {
//        return UIBarButtonItem(customView: button(withImage: "Info", action: action)!)
//    }
//
//    func showInfo() {
//        let controller = storyboard?.instantiateViewController(withIdentifier: "InfoViewController") as? InfoViewController
//        if let controller = controller {
//            present(controller, animated: true)
//        }
//    }
//}

// MARK: Clear log menu
protocol ClearLogOptionInViewController: OptionMenuProtocol {
    func trashItem(withAction action: Selector) -> UIBarButtonItem?
}

extension ClearLogOptionInViewController where Self : UIViewController{
    func trashItem(withAction action: Selector) -> UIBarButtonItem? {
        return UIBarButtonItem(customView: button(withImage: "Trash", action: action)!)
    }
}

// MARK: Reload ad menu
protocol ReloadAdOptionInViewController: OptionMenuProtocol {
    func reloadItem(withAction action: Selector) -> UIBarButtonItem?
}

extension ReloadAdOptionInViewController where Self : UIViewController{
    func reloadItem(withAction action: Selector) -> UIBarButtonItem? {
        return UIBarButtonItem(customView: button(withImage: "Refresh", action: action)!)
    }
}

// MARK: More option ad menu
protocol MoreAdOptionInViewController: OptionMenuProtocol {
    func moreItem(withAction action: Selector) -> UIBarButtonItem?
}

extension MoreAdOptionInViewController where Self : UIViewController{
    func moreItem(withAction action: Selector) -> UIBarButtonItem? {
        return UIBarButtonItem(customView: button(withImage: "more", action: action)!)
    }
}
protocol VisibilityStringWithAdSource {
    func visibilityStringWithAdSource(adSource : AdSource) -> String
}


func visibilityStringWithAdSource(with source: AdSource?) -> String? {
    return source != nil ? visibilityStringWithAdSources(with: [source!]) : "-"
}

func visibilityStringWithAdSources(with sources: [AdSource]?) -> String? {
    var str = ""
    if(sources != nil)
    {
        for (_ , source) in sources!.enumerated() {
            append(source.adVisibility, to: &str)
        }
    }
    return str
}

func visibilityString(withControllers controllers: [ItemAdViewController]?) -> String? {
    var str = ""
    if controllers != nil{
        for (_ , controller) in controllers!.enumerated() {
            if(controller.hasAd){
                append(controller.adVisibilityString(), to: &str)
            }
        }
        return str
    }
    return str
}

func append(_ str1: String?, to str2: inout String) {
    if str2.count > 0 {
        str2 += ", "
    }
    str2 += str1 ?? ""
}
