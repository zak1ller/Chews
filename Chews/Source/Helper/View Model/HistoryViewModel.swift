//
//  HistoryViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/13.
//

import Foundation
import SwiftUI

final class HistoryViewModel: ObservableObject {
  var uiTabBarController: UITabBarController?
  
  @Published var topics: [Topic]
  @Published var showingDetailView = false
  @Published var selectedTopic: Topic = Topic()
  
  init(topics: [Topic]) {
    self.topics = topics
  }
}

extension HistoryViewModel {
  func openDetailView(topic: Topic) {
    selectedTopic = topic
    showingDetailView = true
  }
}
