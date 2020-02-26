//
//  AppDelegate.swift
//  v2rayTray
//
//  Created by dreamldx on 2020/2/26.
//  Copyright © 2020 dreamldx. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var item: NSStatusItem!
    var v2ray: Process!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        v2ray = Process()
        v2ray.executableURL =  Bundle.main.url(forResource: "v2ray", withExtension: "")
        let url = Bundle.main.url(forResource: "config", withExtension: "json")
        v2ray.arguments = ["-config", url!.path as String]
        
        do {
        try v2ray.run()
        } catch {
                
        }
        
        let bar = NSStatusBar.system
        item = bar.statusItem(withLength: NSStatusItem.squareLength)
        item.button?.title = "V2"
        
        let menu = NSMenu(title: "Context")
        item.menu = menu
        
        menu.addItem(
            withTitle: "Exit",
            action: #selector(AppDelegate.exitApplication),
            keyEquivalent: ""
        )
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        v2ray.terminate()
    }
    
    @objc
    func exitApplication() {
        v2ray.terminate()
        exit(0)
    }
    
}

