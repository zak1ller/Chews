//
//  WriteViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/12.
//

import Foundation

final class WriteViewModel: ObservableObject {
  @Published var topic = ""
  @Published var errorMessage = ""
  @Published var showingErrorMessage = false
  @Published var showingGoodPointView = false
  
  func next() {
    if topic.count == 0 {
      errorMessage = "AddViewShortTopicMessage".localized()
      showingErrorMessage = true
    } else if topic.count > 50 {
      errorMessage = "AddViewLongTopicMessage".localized()
      showingErrorMessage = true
    } else {
      showingGoodPointView = true
    }
  }
}
