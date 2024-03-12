//
//  AppLog.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 17/05/21.
//

import Foundation

class AppLog {
    
    static let sharedAppLog = AppLog()
    private(set) var logs = [String]()
    
    func addLog(log: String) {
        logs.append(log)
    }
    
    func clear() {
        logs.removeAll()
    }
}
