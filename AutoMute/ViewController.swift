//
//  ViewController.swift
//  AutoMute
//
//  Created by Lorenzo Gentile on 2015-08-30.
//  Copyright © 2015 Lorenzo Gentile. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet weak var tableView: NSTableView!
    
    // MARK: NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return WifiManager.networks.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        if tableColumn?.identifier == ColumnIds.network {
            return WifiManager.networks[row].valueForKey(NetworkKeys.ssid)
        } else if tableColumn?.identifier == ColumnIds.action {
            return WifiManager.networks[row].valueForKey(NetworkKeys.action)
        }
        return nil
    }
    
    func tableView(tableView: NSTableView, setObjectValue object: AnyObject?, forTableColumn tableColumn: NSTableColumn?, row: Int) {
        if let selectedSegment = object as? Int where tableColumn?.identifier == ColumnIds.action {
            WifiManager.updateActionForNetwork(selectedSegment, index: row)
        }
    }
    
    // MARK: NSTableViewDelegate
    
    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return false
    }
    
    func tableView(tableView: NSTableView, shouldTrackCell cell: NSCell, forTableColumn tableColumn: NSTableColumn?, row: Int) -> Bool {
        return true
    }

}
