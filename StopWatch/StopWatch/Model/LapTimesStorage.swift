//
//  LabTimes.swift
//  StopWatch
//
//  Created by Amirzhan Armandiyev on 20.10.2022.
//

import Foundation

struct LapTimesStorage {
    var labArr: [String] = []
    var minVal: String = ""
    var maxVal: String = ""
    
    var size: Int {
        labArr.count
    }
    
    mutating func addTime(_ time: String) {
        labArr.append(time)
        
        if(minVal.isEmpty || time < minVal) {
            minVal = time
        }
        
        if(maxVal.isEmpty || time > maxVal) {
            maxVal = time
        }
    }
}
