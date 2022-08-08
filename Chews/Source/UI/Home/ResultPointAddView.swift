//
//  ResultPointAddView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/08.
//

import Foundation
import SwiftUI

struct ResultPointAddView: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var points: [Point]
  @State private var value = ""
  @State private var errorMessage = "";
  @State private var showingErrorMessage = false
  @FocusState private var focused: Bool
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      textField
      Spacer()
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
        self.focused = true
      })
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          add()
        }) {
          Text("DoneButton".localized())
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
    .padding(.horizontal, 16)
    .navigationTitle(Text("AddTitle".localized()))
  }
}

extension ResultPointAddView {
  var textField: some View {
    TextField("", text: $value, onCommit: {
      add()
    })
    .focused($focused)
    .typeFieldStyle()
  }
}

extension ResultPointAddView {
  func add() {
    if value.isEmpty {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      let point = Point()
      point.title = value
      points.append(point)
      self.presentationMode.wrappedValue.dismiss()
    }
  }
}
