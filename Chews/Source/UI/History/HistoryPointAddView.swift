//
//  HistoryAddView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/07.
//

import Foundation
import SwiftUI

struct HistoryPointAddView: View {
  let pointType: PointType
  
  @Environment(\.presentationMode) var presentationMode
  
  @Binding var topic: Topic
  @Binding var uiTabarController: UITabBarController?
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
        self.uiTabarController?.tabBar.isHidden = true
      })
    }.onDisappear{
      uiTabarController?.tabBar.isHidden = false
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

extension HistoryPointAddView {
  var textField: some View {
    TextField("", text: $value, onCommit: {
      add()
    })
    .focused($focused)
    .typeFieldStyle()
  }
}

extension HistoryPointAddView {
  func add() {
    if value.isEmpty {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      topic.addPoint(text: value, pointType: pointType)
      self.presentationMode.wrappedValue.dismiss()
    }
  }
}
