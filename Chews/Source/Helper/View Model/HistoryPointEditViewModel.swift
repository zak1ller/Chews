//
//  HistoryPointEditViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/13.
//

import Foundation
import SwiftUI

final class HistoryPointEditViewModel: ObservableObject {
  @Binding var point: Point!
  @Binding var activePointEditView: Bool
  
  @Published var value = ""
  @Published var errorMessage = "";
  @Published var showingErrorMessage = false
  
  init(point: Binding<Point?>, activePointEditView: Binding<Bool>) {
    self._point = point
    self._activePointEditView = activePointEditView
  }
}

extension HistoryPointEditViewModel {
  func save() {
    if value.isEmpty {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      point.edit(title: value)
      activePointEditView = false
    }
  }
}
