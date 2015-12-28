//
//  AppDelegate.swift
//  AutoMute
//
//  Created by Lorenzo Gentile on 2015-08-30.
//  Copyright © 2015 Lorenzo Gentile. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, WifiManagerDelegate {
    private let storyboard = NSStoryboard(name: Storyboards.setupWindow, bundle: nil)
    private var windowController: NSWindowController?
    private let wifiManager = WifiManager()
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(NSVariableStatusItemLength)
    private let menu = NSMenu()
    private let currentNetworkItem = NSMenuItem(title: "", action: "", keyEquivalent: "")
    private let infoItem = NSMenuItem(title: "", action: "", keyEquivalent: "")
    private var lastActionDate: NSDate? = nil
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        wifiManager.delegate = self
        wifiManager.startWifiScanning()
        LaunchAtLoginController().setLaunchAtLogin(true, forURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
        configureStatusBarMenu()
        showSetupIfFirstLaunch()
    }
    
    private func configureStatusBarMenu() {
        statusItem.button?.image = NSImage(named: "StatusBarIcon")
        statusItem.button?.sendActionOn(Int(NSEventMask.LeftMouseDownMask.rawValue))
        statusItem.button?.action = Selector("pressedStatusIcon")
        menu.addItem(currentNetworkItem)
        menu.addItem(infoItem)
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Preferences...", action: Selector("showSetupWindow"), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Quit AutoMute", action: Selector("terminate:"), keyEquivalent: ""))
    }
    
    private func showSetupIfFirstLaunch() {
        if !NSUserDefaults.standardUserDefaults().boolForKey(DefaultsKeys.launchedBefore) {
            showSetupWindow()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: DefaultsKeys.launchedBefore)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    // MARK: Button Handling
    
    func pressedStatusIcon() {
        updateCurrentNetworkItem()
        updateInfoItem()
        statusItem.popUpStatusItemMenu(menu)
    }
    
    func showSetupWindow() {
        if let visible = windowController?.window?.visible where visible {
            NSApp.activateIgnoringOtherApps(true)
        } else {
            windowController = storyboard.instantiateInitialController() as? NSWindowController
            windowController?.showWindow(self)
            windowController?.window?.level = Int(CGWindowLevelForKey(CGWindowLevelKey.PopUpMenuWindowLevelKey))
            NSApp.activateIgnoringOtherApps(true)
        }
    }
    
    private func updateCurrentNetworkItem() {
        currentNetworkItem.title = "Current wifi network: \(wifiManager.currentNetwork())"
    }
    
    private func updateInfoItem() {
        if let date = lastActionDate {
            let action = wifiManager.currentAction()
            let actionDescription: String
            switch action {
            case .Mute: actionDescription = "Muted volume"
            case .Unmute: actionDescription = "Unmuted volume"
            default: actionDescription = wifiManager.currentNetwork() != "not connected" ? "Last connected" : "Disconnected"
            }
            infoItem.title = "\(actionDescription) \(date.naturalDate)"
        } else {
            infoItem.title = "Connecting to this network will: \(wifiManager.currentAction().description)"
        }
    }
    
    // MARK: WifiManagerDelegate
    
    func performAction(action: Action) {
        lastActionDate = NSDate()
        switch action {
        case .Mute: NSSound.applyMute(true)
        case .Unmute: NSSound.applyMute(false)
        default: break
        }
    }
}

extension NSDate {
    private static var dateFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.timeZone = NSTimeZone.defaultTimeZone()
        formatter.doesRelativeDateFormatting = true
        formatter.dateStyle = .MediumStyle
        return formatter
    }()
    
    private static var timeFormatter: NSDateFormatter = {
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        return formatter
    }()
    
    var naturalDate: String {
        let dateString = NSDate.dateFormatter.stringFromDate(self)
        if dateString == "Today" {
            return "at \(NSDate.timeFormatter.stringFromDate(self))"
        }
        return "\(dateString) at \(NSDate.timeFormatter.stringFromDate(self))"
    }
}
