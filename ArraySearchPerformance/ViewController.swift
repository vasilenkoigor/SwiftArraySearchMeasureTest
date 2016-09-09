//
//  ViewController.swift
//  ArraySearchPerformance
//
//  Created by Igor Vasilenko on 09/09/16.
//  Copyright © 2016 Igor Vasilenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var contentArray: [Int] {
        var array = [Int]()
        for value in 0..<100000000 {
            array.append(value)
        }
        return array
    }

    func printTimeElapsedWhenRunningCode(title:String, operation:()->()) {
        let startTime = CFAbsoluteTimeGetCurrent()
        operation()
        let timeElapsed = CFAbsoluteTimeGetCurrent() - startTime
        print("Time elapsed for \(title): \(timeElapsed) s")
    }

    
    @IBAction func performStandardSearch(sender: AnyObject) {
        printTimeElapsedWhenRunningCode("standard") { 
            self.contentArray.indexOf(10000000)
        }
    }
    
    @IBAction func performBinarySearch(sender: AnyObject) {
        printTimeElapsedWhenRunningCode("binary") { 
            self.contentArray.indexOf(10000000, range: 0..<100000000)
        }
    }
}

extension Array where Element : Comparable {
    
    // Binary search index of passed element.
    // Passed Array should be only sorted.
    public func indexOf(key: Element, range: Range<Int>) -> Int? {
        if self.count == 1 {
            return self.first == key ? 0 : nil
        }
        
        var lowerBound = range.startIndex
        var upperBound = range.endIndex
        while lowerBound < upperBound {
            let midIndex = lowerBound + (upperBound - lowerBound) / 2
            if self[midIndex] == key {
                return midIndex
            } else if self[midIndex] < key {
                lowerBound = midIndex + 1
            } else {
                upperBound = midIndex
            }
        }
        
        return nil
    }
}



