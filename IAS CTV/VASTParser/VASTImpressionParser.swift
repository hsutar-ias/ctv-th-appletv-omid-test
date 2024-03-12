//
//  VASTImpressionParser.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 13/05/21.
//

import Foundation

class VASTImpressionParser: VASTBaseParser {
    private(set) lazy var impression = OMIDImpression()
    
    override func foundCDATA(_ CDATABlockString: String?) {
        impression.impressionUrl = CDATABlockString
    }
}
