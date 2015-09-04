//
//  AppDelegate.swift
//  Auto Volume
//
//  Created by Lorenzo Gentile on 2015-08-30.
//  Copyright © 2015 Lorenzo Gentile. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate, WifiManagerDelegate {
    private lazy var windowController: NSWindowController = {
        let storyboard = NSStoryboard(name: Storyboards.setupWindow, bundle: nil)
        return storyboard.instantiateInitialController() as? NSWindowController ?? NSWindowController()
    }()
    private let wifiManager = WifiManager()
    private let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)
    private let menu = NSMenu()
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        wifiManager.delegate = self
        wifiManager.startWifiScanning()
        LaunchAtLoginController().setLaunchAtLogin(true, forURL: NSURL(fileURLWithPath: NSBundle.mainBundle().bundlePath))
        configureStatusBarMenu()
        showSetupIfFirstLaunch()
    }
    
    private func configureStatusBarMenu() {
        statusItem.button?.image = NSImage(named: "StatusBarIcon")
        statusItem.menu = menu
        menu.addItem(NSMenuItem(title: "AutoMute", action: Selector(""), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Preferences...", action: Selector("showSetupWindow"), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separatorItem())
        menu.addItem(NSMenuItem(title: "Quit", action: Selector("terminate:"), keyEquivalent: ""))
    }
    
    private func showSetupIfFirstLaunch() {
        if !NSUserDefaults.standardUserDefaults().boolForKey(DefaultsKeys.launchedBefore) {
            showSetupWindow()
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: DefaultsKeys.launchedBefore)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func showSetupWindow() {
        windowController.showWindow(self)
    }
    
    // MARK: WifiManagerDelegate
    
    func wifiNetworkDidChange(ssid: String?) {
        if let ssid = ssid, action = NSUserDefaults.standardUserDefaults().valueForKey(ssid) as? Int {
            switch action {
            case Actions.Mute: NSSound.applyMute(true)
            case Actions.Unmute: NSSound.applyMute(false)
            default: break
            }
        }
    }
    
}
