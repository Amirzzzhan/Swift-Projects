//
//  Time.swift
//  StopWatch
//
//  Created by Amirzhan Armandiyev on 20.10.2022.
//

import Foundation

struct Time {
    private var milliseconds: Int = 0
    private var seconds: Int = 0
    private var minutes: Int = 0
    
    public var description: String {
        converter(toString: minutes) + ":" + converter(toString: seconds) + "." + converter(toString: milliseconds)
    }
    
    mutating func increment() {
        milliseconds += 1
        if(milliseconds == 100) {
            milliseconds = 0
            seconds += 1
            if(seconds == 60) {
                seconds = 0
                minutes += 1
            }
        }
    }
    
    private func converter(toString sec: Int) -> String {
        if(sec < 10) {
            return "0" + String(sec)
        } else {
            return String(sec)
        }
    }
}
