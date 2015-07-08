//
//  DNDViewController.swift
//  MSC DND
//
//  Created by Graham Gilbert on 05/07/2015.
//  Copyright (c) 2015 Graham Gilbert. All rights reserved.
//

import Cocoa
import CoreFoundation
import Foundation

class DNDViewController: NSViewController {
    
    @IBOutlet var textLabel: NSTextField!
    @IBOutlet var enableButton: NSButton!
    @IBOutlet var quitButton: NSButton!
    @IBOutlet var descriptionLabel: NSTextField!
    
    var dndactive = false
    let bundleid = "com.grahamgilbert.mscdnd"
    
    let plistPath = "/Users/Shared"
    var dndHours = 24
    var notificationsEnabled = true
    
    override func loadView() {
        super.loadView()
        activeCheck()
        
    }
    
    
    func activeCheck(){
        let plist = plistPath.stringByAppendingPathComponent(".msc-dnd.plist")
        let fileManager = NSFileManager.defaultManager()
        if(fileManager.fileExistsAtPath(plist)) {
            //read in the plist, check the time
            var data = readDateFromPlist()
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let formattedDate = dateFormatter.dateFromString(data)
            
            let now = NSDate()
            
            if(formattedDate! < now)
            {
                print("Stored date is before now, reset the UI")
                updateDescription()
                enableUI()
                
                
            }else{
                print("Stored date is after now, disable the UI and start timer")
                disableUI(formattedDate!.formattedWith("yyyy-MM-dd HH:mm:ss"))
                checkStateOnTimer()
            }
            
        }else{
            print("file doesn't exist, set everything back to default")
            updateDescription()
            enableUI()
        }
    }
    
    func checkStateOnTimer(){
        var timer = NSTimer()
        print("Starting timer")
        timer = NSTimer.scheduledTimerWithTimeInterval(15, target:self, selector: Selector("activeCheck"), userInfo: nil, repeats: false)
        
    }
    
    
    func updateDescription(){
        let prefValue = CFPreferencesCopyAppValue("DNDHours", bundleid) as? Int
        
        if prefValue != nil {
            dndHours = prefValue!
        }
        
        var descriptionString = ""
        
        if dndHours == 1{
            descriptionString = "Notifications for updates by Managed Software Center will be suppressed for \(dndHours) hour."
        } else{
            descriptionString = "Notifications for updates by Managed Software Center will be suppressed for \(dndHours) hours."
        }
        
        descriptionLabel.stringValue = descriptionString
        
    }
    
    func visibleUpdate(){
        descriptionLabel.hidden = false
    }
    
    
    func addHoursToCurrDateTime(hours: Int) -> String{
        let seconds = hours * 60 * 60
        let now = NSDate(timeIntervalSinceNow:Double(seconds))
        return now.formattedWith("yyyy-MM-dd HH:mm:ss")
    }
    
    func writeDateToPlist(date: String){
        //Convert String to NSDate
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.dateFromString(date)
        let plist = plistPath.stringByAppendingPathComponent(".msc-dnd.plist")
        let fileManager = NSFileManager.defaultManager()
        //It's easier if I start the dict off with some junk data until I know what I'm doing
        var dict: NSMutableDictionary = ["DNDEndDate": "DoNotEverChangeMe"]
        dict.setObject(formattedDate!, forKey: "DNDEndDate")
        dict.writeToFile(plist, atomically: false)
    }
    
    func readDateFromPlist() -> String{
        //Make sure the file exists
        let plist = plistPath.stringByAppendingPathComponent(".msc-dnd.plist")
        let fileManager = NSFileManager.defaultManager()
        if(fileManager.fileExistsAtPath(plist)) {
            var resultDictionary = NSDictionary(contentsOfFile: plist)
            var date = resultDictionary!.valueForKey("DNDEndDate") as? NSDate
            return date!.formattedWith("yyyy-MM-dd HH:mm:ss")
        }else{
            return ""
        }
    }
    
    func disableUI(date: String){
        notificationsEnabled = false
        enableButton.title = "Enable Notifications"
        textLabel.stringValue = "Notifications Disabled"
        descriptionLabel.stringValue = "Notifications will resume \(date)"
    }
    
    func enableUI(){
        notificationsEnabled = true
        enableButton.title = "Stop Notifications"
        textLabel.stringValue = "Notifications Active"
        updateDescription()
        visibleUpdate()
    }
    
    
}

extension DNDViewController {
    
    @IBAction func quit(sender: NSButton) {
        NSApplication.sharedApplication().terminate(sender)
    }
    
    @IBAction func stopNotifications(sender: AnyObject) {
        //Calculate the time difference
        let dndEndDate = addHoursToCurrDateTime(dndHours)
        print(notificationsEnabled)
        if notificationsEnabled {
            //Write plist
            writeDateToPlist(dndEndDate)
            //Disable ui
            disableUI(dndEndDate)
            checkStateOnTimer()
        }
        else {
            var error: NSError?
            let plist = plistPath.stringByAppendingPathComponent(".msc-dnd.plist")
            let fileManager = NSFileManager.defaultManager()
            fileManager.removeItemAtPath(plist, error: &error)
            enableUI()
        }
    }
    
    
}

extension NSDate {
    
    // you can create a read-only computed property to return just the nanoseconds as Int
    var nanosecond: Int { return NSCalendar.currentCalendar().component(.CalendarUnitNanosecond,  fromDate: self)   }
    
    // or an extension function to format your date
    func formattedWith(format:String)-> String {
        let formatter = NSDateFormatter()
        //formatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)  // you can set GMT time
        formatter.timeZone = NSTimeZone.localTimeZone()        // or as local time
        formatter.dateFormat = format
        return formatter.stringFromDate(self)
    }
    
}

public func ==(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs === rhs || lhs.compare(rhs) == .OrderedSame
}

public func <(lhs: NSDate, rhs: NSDate) -> Bool {
    return lhs.compare(rhs) == .OrderedAscending
}

extension NSDate: Comparable { }
