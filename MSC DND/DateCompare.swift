//
//  DateCompare.swift
//  MSC DND
//
//  Created by Graham Gilbert on 06/07/2015.
//  Copyright (c) 2015 Graham Gilbert. All rights reserved.
//

import Foundation
//extension NSDate
//    {
//        func isGreaterThanDate(dateToCompare : NSDate) -> Bool
//        {
//            //Declare Variables
//            var isGreater = false
//            
//            //Compare Values
//            if self.compare(dateToCompare) == NSComparisonResult.OrderedDescending
//            {
//                isGreater = true
//            }
//            
//            //Return Result
//            return isGreater
//        }
//        
//        
//        func isLessThanDate(dateToCompare : NSDate) -> Bool
//        {
//            //Declare Variables
//            var isLess = false
//            
//            //Compare Values
//            if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending
//            {
//                isLess = true
//            }
//            
//            //Return Result
//            return isLess
//        }
//        
//        
//        func isEqualToDate(dateToCompare : NSDate) -> Bool
//        {
//            //Declare Variables
//            var isEqualTo = false
//            
//            //Compare Values
//            if self.compare(dateToCompare) == NSComparisonResult.OrderedSame
//            {
//                isEqualTo = true
//            }
//            
//            //Return Result
//            return isEqualTo
//        }
//        
//        
//        
//        func addDays(daysToAdd : Int) -> NSDate
//        {
//            var secondsInDays : NSTimeInterval = Double(daysToAdd) * 60 * 60 * 24
//            var dateWithDaysAdded : NSDate = self.dateByAddingTimeInterval(secondsInDays)
//            
//            //Return Result
//            return dateWithDaysAdded
//        }
//        
//        
//        func addHours(hoursToAdd : Int) -> NSDate
//        {
//            var secondsInHours : NSTimeInterval = Double(hoursToAdd) * 60 * 60
//            var dateWithHoursAdded : NSDate = self.dateByAddingTimeInterval(secondsInHours)
//            
//            //Return Result
//            return dateWithHoursAdded
//        }
//}