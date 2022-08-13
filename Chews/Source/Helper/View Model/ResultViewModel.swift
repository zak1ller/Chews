//
//  ResultViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/13.
//

import Foundation

final class ResultViewModel: ObservableObject {
  let topic: String
  var selectedIndex = 0
  
  @Published var goodPoints: [Point]
  @Published var badPoints: [Point]
  @Published var goodPointScore = ""
  @Published var badPointScore = ""
  @Published var isSelectedGoodPoint = false
  @Published var showingPointEditView = false
  @Published var showingPointAddView = false
  @Published var hiddenTrigger = false
  
  init(topic: String, goodPoints: [Point], badPoints: [Point]) {
    self.topic = topic
    self.goodPoints = goodPoints
    self.badPoints = badPoints
  }
  
  func add(pointType: PointType) {
    switch pointType {
    case .good:
      isSelectedGoodPoint = true
    case .bad:
      isSelectedGoodPoint = false
    }
    showingPointAddView = true
  }
  
  func edit(_ i: Int, pointType: PointType) {
    switch pointType {
    case .good:
      isSelectedGoodPoint = true
    case .bad:
      isSelectedGoodPoint = false
    }
    selectedIndex = i
    showingPointEditView = true
  }
  
  func delete(_ i: Int, pointType: PointType) {
    switch pointType {
    case .good:
      goodPoints.remove(at: i)
    case .bad:
      badPoints.remove(at: i)
    }
  }
  
  func updateScore() {
    var value = 0
    goodPoints.forEach {
      value += $0.score
    }
    goodPointScore = "\(value)"
    
    value = 0
    badPoints.forEach {
      value += $0.score
    }
    badPointScore = "\(value)"
  }
  
  func finish() -> Bool {
    Topic.add(
      topic: topic,
      goodPoints: goodPoints,
      badPoints: badPoints
    )
    return false
  }
}
