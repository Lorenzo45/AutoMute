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

struct Actions {
    static let Mute = 0
    static let Unmute = 1
    static let DoNothing = 2
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
