//
//  WifiManager.swift
//  AutoMute
//
//  Created by Lorenzo Gentile on 2015-08-31.
//  Copyright © 2015 Lorenzo Gentile. All rights reserved.
//

import Foundation
import CoreWLAN

protocol WifiManagerDelegate: class {
    func performAction(action: Action)
}

class WifiManager: NSObject {
    private let wifiInterface = CWWiFiClient.sharedWiFiClient().interface()
    private var lastSSID: String?
    weak var delegate: WifiManagerDelegate?
    static var networks = WifiManager.getUsedNetworks()
    
    override init() {
        lastSSID = NSUserDefaults.standardUserDefaults().valueForKey(DefaultsKeys.lastSSID) as? String
    }
    
    // Retrieves network info from the user's preferences, returns only the networks that have been connected to and sorted by date last used
    // Also checks user defaults for the actions associated to that network and adds it as a property to the preferences
    private class func getUsedNetworks() -> [[String: AnyObject]] {
        var usedNetworks = [[String: AnyObject]]()
        let airportPreferences = NSDictionary(contentsOfFile: Paths.airportPreferences) as? [String: AnyObject]
        guard let knownNetworks = airportPreferences?[NetworkKeys.knownNetworks] as? [String: AnyObject] else { return usedNetworks }
        for (_, object) in knownNetworks {
            if var network = object as? [String: AnyObject], let ssid = network[NetworkKeys.ssid] as? String {
                if network[NetworkKeys.lastConnected] != nil {
                    let action = NSUserDefaults.standardUserDefaults().objectForKey(ssid) as? Int ?? Action.DoNothing.rawValue
                    network[NetworkKeys.action] = action
                    usedNetworks += [network]
                }
            }
        }
        usedNetworks.sortInPlace { (first, second) -> Bool in
            if let firstDate = first[NetworkKeys.lastConnected] as? NSDate, secondDate = second[NetworkKeys.lastConnected] as? NSDate {
                return firstDate.compare(secondDate) == NSComparisonResult.OrderedDescending
            }
            return true
        }
        return usedNetworks
    }
    
    class func updateActionForNetwork(action: Int, index: Int) {
        WifiManager.networks[index][NetworkKeys.action] = action
        if let ssid = WifiManager.networks[index][NetworkKeys.ssid] as? String {
            NSUserDefaults.standardUserDefaults().setValue(action, forKey: ssid)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func currentNetwork() -> String {
        return lastSSID ?? "not connected"
    }
    
    func currentAction() -> Action {
        if let action = NSUserDefaults.standardUserDefaults().objectForKey(currentNetwork()) as? Int {
            return Action(rawValue: action) ?? Action.DoNothing
        }
        return Action.DoNothing
    }
    
    // MARK: Scanning current network
    
    func startWifiScanning() {
        checkSSID()
        let ssidTimer = NSTimer(timeInterval: Constants.wifiCheckTimeInterval, target: self, selector: Selector("checkSSID"), userInfo: nil, repeats: true)
        NSRunLoop.mainRunLoop().addTimer(ssidTimer, forMode: NSRunLoopCommonModes)
    }
    
    func checkSSID() {
        let ssid = wifiInterface?.ssid()
        if lastSSID != ssid {
            lastSSID = ssid
            delegate?.performAction(currentAction())
            NSUserDefaults.standardUserDefaults().setValue(lastSSID, forKey: DefaultsKeys.lastSSID)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
}
