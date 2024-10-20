//
//  Date.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 24/08/2024.
//

import Foundation
import EMLECore

extension Date {
    
    static func getTimeIntervalString(from date: Date) -> String {
        let now = Date()
        let timeInterval = now.timeIntervalSince(date)
        
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.unitsStyle = .abbreviated
        componentsFormatter.allowedUnits = timeInterval.toDateComponentsUnit()
        
        let timeString = componentsFormatter.string(from: timeInterval)!
        
        return BasicStrings.sAgo.localizedFormat(arguments: timeString)
    }
    
    static func getVideosDurationString(from videosDuration: Int) -> String {
        
        let timeInterval = TimeInterval(videosDuration)
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.unitsStyle = .full
        componentsFormatter.allowedUnits = timeInterval.toVideosDurationDateComponentsUnit()
        
        let timeString = componentsFormatter.string(from: timeInterval)!
        
        return timeString
    }
    
    static func getVideoPlayerDurationString(from duration: Double, units: NSCalendar.Unit) -> String {
        
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.unitsStyle = .positional
        componentsFormatter.zeroFormattingBehavior = .pad
        componentsFormatter.allowedUnits = units
        
        let timeString = componentsFormatter.string(from: duration)!
        
        return timeString
    }
    
    static func getQuizDurationString(from quizDuration: Int) -> String {
        
        let timeInterval = TimeInterval(quizDuration)
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.unitsStyle = .full
        componentsFormatter.allowedUnits = timeInterval.toQuizDurationDateComponentsUnit()
        
        let timeString = componentsFormatter.string(from: timeInterval)!
        
        return timeString
    }
    
    static func getQuizRemainingDurationString(from remainingDuration: Int) -> String {
        
        let timeInterval = TimeInterval(remainingDuration)
        let componentsFormatter = DateComponentsFormatter()
        componentsFormatter.unitsStyle = .positional
        componentsFormatter.zeroFormattingBehavior = .pad
        componentsFormatter.allowedUnits = timeInterval.toQuizRemainingDurationDateComponentsUnit()
        
        let timeString = componentsFormatter.string(from: timeInterval)!
        
        return timeString
    }
}
