//
//  HistoryDetailViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/13.
//

import Foundation
import SwiftUI

final class HistoryDetailViewModel: ObservableObject {
  @Binding var topic: Topic
  @Binding var activeDetailView: Bool
  
  @Published var showingPointEditView = false
  @Published var showingPointAddView = false
  @Published var selectedPoint: Point?
  @Published var selectedPointType: PointType = .good
  @Published var goodPointScore = ""
  @Published var badPointScore = ""
  
  init(topic: Binding<Topic>, activeDetailView: Binding<Bool>) {
    self._topic = topic
    self._activeDetailView = activeDetailView
  }
}

extension HistoryDetailViewModel {
  func updateScore() {
    var value = 0
    topic.goods.forEach {
      value += $0.score
    }
    goodPointScore = "\(value)"
    
    value = 0
    topic.bads.forEach {
      value += $0.score
    }
    badPointScore = "\(value)"
  }
  
  func delete() {
    Topic.delete(topic: topic)
    activeDetailView = false
  }
  
  func add(pointType: PointType) {
    selectedPointType = pointType
    showingPointAddView = true
  }
  
  func edit(_ point: Point, pointType: PointType, i: Int) {
    selectedPoint = point
    selectedPointType = pointType
    showingPointEditView = true
  }
  
  func delete(_ point: String, pointType: PointType) {
    topic.deletePoint(point: point, pointType: pointType)
    updateScore()
  }
}
