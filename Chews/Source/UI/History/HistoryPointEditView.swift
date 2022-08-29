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
  @StateObject var viewModel: HistoryPointEditViewModel
  @FocusState private var focused: Bool
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      pointTextField
      Spacer()
    }
    .onAppear {
      viewModel.value = viewModel.point.title
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        self.focused = true
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          viewModel.save()
          presentationMode.wrappedValue.dismiss()
        }) {
          Text("SaveButton".localized())
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
    .navigationTitle(Text("EditTitle".localized()))
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}

extension HistoryPointEditView {
  var pointTextField: some View {
    TextField(viewModel.point.title, text: $viewModel.value, onCommit: {
      viewModel.save()
      presentationMode.wrappedValue.dismiss()
    })
    .focused($focused)
    .typeFieldStyle()
  }
}
