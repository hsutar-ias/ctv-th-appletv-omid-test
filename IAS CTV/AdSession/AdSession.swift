//
//  AdSession.swift
//  tvdummyapp
//
//  Created by Akshay Patil on 17/05/21.
//

import Foundation

struct SessionLog: Codable {
    var sessionId: String
    var sessionType: String
    var time = Int(Date().timeIntervalSince1970)
    var error: String?
    
    
    func toJsonString() -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        let data = try! encoder.encode(self)
        return String(data: data, encoding: .utf8)!
    }
}

class AdSession: NSObject {
    var uuid: String?
    
    func start() {
        uuid = UUID().uuidString
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "start")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func mediaPlay() {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "play")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func mediaPaused() {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "pause")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func mediaResumed() {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "resume")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func firstQuartile() {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "firstQuartile")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func midpoint(){
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "midpoint")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func thirdQuartile() {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "thirdQuartile")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func endOfPlayingVideo() {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "end")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func errorWhilePlayingVideo(msg: String) {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "error", error: msg)
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func playerSkipped() {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "skipped")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
    
    func volumeChanged(volume:Float) {
        let sessionLog = SessionLog(sessionId: uuid!, sessionType: "volumeChanged")
        AppLog.sharedAppLog.addLog(log: sessionLog.toJsonString())
    }
}
