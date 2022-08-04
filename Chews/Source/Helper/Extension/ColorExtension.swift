//
//  ColorExtension.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import SwiftUI

extension Color {
  static let appBackgroundColor = Color(hex: "#FFFFFF")
  static let appBackgroundSubColor = Color(hex: "#F0F3F4")
  static let appPointColor = Color(hex: "#000000")
  static let appTextColor = Color(hex: "#212121")
  static let appTextSubColor = Color(hex: "#CACFD2")
}

extension Color {
  init(hex: String) {
    let scanner = Scanner(string: hex)
    _ = scanner.scanString("#")
    
    var rgb: UInt64 = 0
    scanner.scanHexInt64(&rgb)
    
    let r = Double((rgb >> 16) & 0xFF) / 255.0
    let g = Double((rgb >>  8) & 0xFF) / 255.0
    let b = Double((rgb >>  0) & 0xFF) / 255.0
    self.init(red: r, green: g, blue: b)
  }
}
