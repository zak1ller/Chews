//
//  BadPointViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/13.
//

import Foundation
import SwiftUI

final class BadPointViewModel: ObservableObject {
  let topic: String
  
  @Published var goodPoints: [Point]
  
  @Published var latestCount = 0
  @Published var badPointValue = ""
  @Published var badPoints: [Point] = []
  @Published var errorMessage = ""
  @Published var showingErrorMessage = false
  @Published var showingResultView = false
  
  init(topic: String, goodPoints: [Point]) {
    self.topic = topic
    self.goodPoints = goodPoints
  }
  
  func next() {
    if badPoints.isEmpty {
      errorMessage = "BadPointEmptyMessage".localized()
      showingErrorMessage = true
    } else {
      showingResultView = true
    }
  }
  
  func enter() -> Bool {
    if badPointValue.count == 0 {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
      return false
    } else {
      let point = Point()
      point.title = badPointValue
      badPoints.append(point)
      badPointValue = ""
      return true
    }
  }
}
