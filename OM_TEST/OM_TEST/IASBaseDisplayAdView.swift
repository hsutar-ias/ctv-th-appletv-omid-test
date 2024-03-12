//
//  IASBaseDisplayAdView.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 08/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

//import Foundation
//
//protocol IASBaseDisplayAdViewDelegate: NSObjectProtocol {
//    func onAdViewTapped(_ adView: IASBaseDisplayAdView?)
//}
//
//public class IASBaseDisplayAdView: UIView {
//    @IBOutlet weak var mainImageView: UIImageView!
//    weak var delegate: IASBaseDisplayAdViewDelegate?
//
//    class func loadFromNib() -> IASBaseDisplayAdView? {
//        return Bundle.main.loadNibNamed("IASDisplayAdView", owner: nil, options: nil)?.first as? IASBaseDisplayAdView
//    }
//
//    @IBAction func adTapped(_ sender: Any) {
//        delegate?.onAdViewTapped(self)
//    }
//}
