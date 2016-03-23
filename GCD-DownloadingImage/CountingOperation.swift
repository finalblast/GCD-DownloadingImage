//
//  CountingOperation.swift
//  GCD-DownloadingImage
//
//  Created by Nam (Nick) N. HUYNH on 3/22/16.
//  Copyright (c) 2016 Enclave. All rights reserved.
//

import UIKit

class CountingOperation: NSOperation {
    
    var startingCount: Int = 0
    var endingCount: Int = 0
    
    init(startCount: Int, endCount: Int) {
    
        self.startingCount = startCount
        self.endingCount = endCount
        
    }
    
    convenience override init() {
        
        self.init(startCount: 0, endCount: 3)
        
    }
    
    override func main() {
        
        var isTaskFinished = false
        while isTaskFinished == false && self.finished == false {
            
            for counter in startingCount ..< endingCount {
                
                println("Count: \(counter)")
                println("Current Thread: \(NSThread.currentThread())")
                println("Main Thread: \(NSThread.mainThread())")
                println("---------------------------------")
                
            }
            
            isTaskFinished = true
            
        }
        
    }
    
}
