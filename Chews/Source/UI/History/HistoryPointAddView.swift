//
//  HistoryAddView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/07.
//

import Foundation
import SwiftUI

struct HistoryPointAddView: View {
  @StateObject var viewModel: HistoryPointAddViewModel
  @Environment(\.presentationMode) var presentationMode
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
          viewModel.add()
          presentationMode.wrappedValue.dismiss()
        }) {
          Text("DoneButton".localized())
            .foregroundColor(.appPointColor)
        }
      }
    }
    .alert("AlertTitle".localized(), isPresented: $viewModel.showingErrorMessage, actions: {
      Button("ConfirmButton".localized(), role: .cancel) {
        viewModel.showingErrorMessage = false
        focused = true
      }
    }, message: {
      Text(viewModel.errorMessage)
    })
    .padding(.horizontal, 16)
    .navigationTitle(Text("AddTitle".localized()))
  }
}

extension HistoryPointAddView {
  var textField: some View {
    TextField("", text: $viewModel.value, onCommit: {
      viewModel.add()
      presentationMode.wrappedValue.dismiss()
    })
    .focused($focused)
    .typeFieldStyle()
  }
}

