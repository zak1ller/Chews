//
//  ChewsApp.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import SwiftUI

@main
struct ChewsApp: App {
  var body: some Scene {
    WindowGroup {
      HomeView()
        .onAppear {
          UINavigationBar.appearance().tintColor = UIColor.black
        }
    }
  }
}
