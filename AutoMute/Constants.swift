//
//  Constants.swift
//  AutoMute
//
//  Created by Lorenzo Gentile on 2015-08-31.
//  Copyright © 2015 Lorenzo Gentile. All rights reserved.
//

import Foundation

struct Constants {
    static let wifiCheckTimeInterval: NSTimeInterval = 2
}

enum Action: Int {
    case Mute = 0
    case Unmute = 1
    case DoNothing = 2
    
    var description: String {
        switch self {
        case .Mute: return "Mute"
        case .Unmute: return "Unmute"
        case .DoNothing: return "Do Nothing"
        }
    }
}

struct Storyboards {
    static let setupWindow = "SetupWindow"
}

struct Paths {
    static let airportPreferences = "/Library/Preferences/SystemConfiguration/com.apple.airport.preferences.plist"
}

struct ColumnIds {
    static let network = "network"
    static let action = "action"
}

struct NetworkKeys {
    static let ssid = "SSIDString"
    static let knownNetworks = "KnownNetworks"
    static let lastConnected = "LastConnected"
    static let action = "action"
}

struct DefaultsKeys {
    static let lastSSID = "lastSSID"
    static let launchedBefore = "launchedBefore"
}
