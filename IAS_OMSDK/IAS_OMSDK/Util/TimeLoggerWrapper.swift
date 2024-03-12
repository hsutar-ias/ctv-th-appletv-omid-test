//
//  TimeLoggerWrapper.swift
//  IASOMID_SDK
//
//  Created by Akshay Patil on 09/09/21.
//  Copyright © 2021 Akshay Patil. All rights reserved.
//


import UIKit
/**
- TimeLoggerWrapper class used for setup timelogs 
*/
public class TimeLoggerWrapper: NSObject {
    public static let sharedTimeLogger = TimeLoggerWrapper()
    
    public func setup() {
        TreeTimeLogger.sharedLog();
    }
    
    public func getTimeLog() -> String {
        return TreeTimeLogger.sharedLog().getTimeLog()
    }
    
    public func clearTimeLog() {
        TreeTimeLogger.sharedLog().clearTimeLog()
    }
}
