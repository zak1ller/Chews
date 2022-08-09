//
//  TopicEditView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/06.
//

import Foundation
import SwiftUI

struct HistoryPointEditView: View {
  @Environment(\.presentationMode) var presentationMode
  
  @Binding var point: Point
  @FocusState private var focused: Bool
  @State private var value = ""
  @State private var errorMessage = "";
  @State private var showingErrorMessage = false
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      pointTextField
      Spacer()
    }
    .onAppear {
      value = point.title
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        self.focused = true
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          save()
        }) {
          Text("SaveButton".localized())
            .foregroundColor(.appPointColor)
        }
      }
    }
    .alert("AlertTitle".localized(), isPresented: $showingErrorMessage, actions: {
      Button("ConfirmButton".localized(), role: .cancel) {
        showingErrorMessage = false
        focused = true
      }
    }, message: {
      Text(errorMessage)
    })
    .navigationTitle(Text("EditTitle".localized()))
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}

extension HistoryPointEditView {
  var pointTextField: some View {
    TextField(point.title, text: $value, onCommit: {
      save()
    })
    .focused($focused)
    .typeFieldStyle()
  }
}

extension HistoryPointEditView {
  func save() {
    if value.isEmpty {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      point.edit(title: value)
      presentationMode.wrappedValue.dismiss()
    }
  }
}
