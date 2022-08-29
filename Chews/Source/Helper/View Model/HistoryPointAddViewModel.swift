//
//  HistoryPointAddViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/13.
//

import Foundation
import SwiftUI

final class HistoryPointAddViewModel: ObservableObject {
  let pointType: PointType
  
  @Binding var topic: Topic
  
  @Published var value = ""
  @Published var errorMessage = "";
  @Published var showingErrorMessage = false
  
  init(topic: Binding<Topic>, pointType: PointType) {
    self._topic = topic
    self.pointType = pointType
  }
}

extension HistoryPointAddViewModel {
  func add() {
    if value.isEmpty {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      topic.addPoint(text: value, pointType: pointType)
    }
  }
}
