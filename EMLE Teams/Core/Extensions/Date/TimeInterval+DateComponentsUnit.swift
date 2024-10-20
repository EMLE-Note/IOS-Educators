//
//  TimeInterval+DateComponentsUnit.swift
//  EMLE Teams
//
//  Created by Ali M. Zaghloul on 24/08/2024.
//

import Foundation

extension TimeInterval {
    
    private func containsYear() -> Bool {
        self > 1 * 60 * 60 * 24 * 30 * 12
    }
    
    private func containsMonth() -> Bool {
        self > 1 * 60 * 60 * 24 * 30
    }
    
    private func containsDay() -> Bool {
        self > 1 * 60 * 60 * 24
    }
    
    private func containsHour() -> Bool {
        self > 1 * 60 * 60
    }
    
    private func containsMinute() -> Bool {
        self > 1 * 60
    }
    
    func toDateComponentsUnit() -> NSCalendar.Unit {
        
        if containsYear() {
            return .year
        }
        
        if containsMonth() {
            return .month
        }
        
        if containsDay() {
            return .day
        }
        
        if containsHour() {
            return .hour
        }
        
        if containsMinute() {
            return .minute
        }
        
        return .second
    }
    
    func toVideosDurationDateComponentsUnit() -> NSCalendar.Unit {
        
        if containsHour() {
            return .hour
        }
        
        if containsMinute() {
            return .minute
        }
        
        return .second
    }
    
    func toQuizDurationDateComponentsUnit() -> NSCalendar.Unit {
        toVideosDurationDateComponentsUnit()
    }
    
    func toVideosTimeDateComponentsUnit() -> NSCalendar.Unit {
        
        if containsHour() {
            return [.hour, .minute, .second]
        }
        
        return [.minute, .second]
    }
    
    func toQuizRemainingDurationDateComponentsUnit() -> NSCalendar.Unit {
        toVideosTimeDateComponentsUnit()
    }
}
