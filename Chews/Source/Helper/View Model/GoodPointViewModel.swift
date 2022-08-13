//
//  GoodPointViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/12.
//

import Foundation
import SwiftUI

final class GoodPointViewModel: ObservableObject {
  var topic: String
  var latestCount = 0
  
  @Published var goodPointValue = ""
  @Published var errorMessage = ""
  @Published var showingErrorMessage = false
  @Published var showingBadPointView = false
  @Published var goodPoints: [Point] = []
  
  init(topic: String) {
    self.topic = topic
  }
  
  func alertConfirmButtonTapped() -> Bool {
    showingErrorMessage = false
    return true
  }
  
  func removePoint(at i: Int) {
    goodPoints.remove(at: i)
  }
  
  func enter() -> Bool {
    if goodPointValue.count == 0 {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      let point = Point()
      point.title = goodPointValue
      
      goodPoints.append(point)
      goodPointValue = ""
    }
    return goodPointValue.count == 0
  }
  
  func next() -> Bool {
    if goodPoints.isEmpty {
      errorMessage = "GoodPointsEmptyMessage".localized()
      showingErrorMessage = true
    } else {
      showingBadPointView = true
    }
    return goodPoints.isEmpty
  }
}
