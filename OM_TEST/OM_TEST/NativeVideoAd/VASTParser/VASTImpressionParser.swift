//
//  VASTImpressionParser.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 20/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//

import Foundation

class VASTImpressionParser: VASTBaseParser {
    private(set) lazy var impression = OMIDImpression()
    
    override func foundCDATA(_ CDATABlockString: String?) {
        impression.impressionUrl = CDATABlockString
    }
}
