//
//  AppDelegate.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/09.
//

import Foundation
import UIKit
import IceCream
import RealmSwift

class AppDelegate: NSObject, UIApplicationDelegate {
  var syncEngine: SyncEngine?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    // Sync realm cloukit
    syncEngine = SyncEngine(objects: [
      SyncObject(type: Point.self),
      SyncObject(type: Topic.self, uListElementType: Point.self)
    ])
    application.registerForRemoteNotifications()
    
    return true
  }
}
