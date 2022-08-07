//
//  ResultPointEditView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/06.
//

import Foundation
import SwiftUI

struct ResultPointEditView: View {
  @Environment(\.presentationMode) var presentationMode
  @Binding var points: [String]
  @Binding var uiTabarController: UITabBarController?
  @FocusState private var focused: Bool
  @State private var value = ""
  @State private var errorMessage = "";
  @State private var showingErrorMessage = false
  
  let index: Int
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      pointTextField
      Spacer()
    }
    .padding(.leading, 16)
    .padding(.trailing, 16)
    .onAppear {
      value = points[index]
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        self.focused = true
        self.uiTabarController?.tabBar.isHidden = true
      }
    }
    .onDisappear {
      self.uiTabarController?.tabBar.isHidden = false
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
  }
}

extension ResultPointEditView {
  var pointTextField: some View {
    TextField(points[index], text: $value, onCommit: {
      save()
    })
    .focused($focused)
    .typeFieldStyle()
  }
}

extension ResultPointEditView {
  func save() {
    if value.isEmpty {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      points[index] = value
      self.presentationMode.wrappedValue.dismiss()
    }
  }
}
