//
//  WriteView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import Foundation
import SwiftUI
import Introspect

struct WriteView: View {
  @FocusState private var focused: Bool
  @StateObject private var viewModel = WriteViewModel()
  
  var body: some View {
    VStack(alignment: .center) {
      topicLabel
      topicTextField
    }
    .introspectTabBarController { (UITabBarController) in
      UITabBarController.tabBar.isHidden = true
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
        self.focused = true
      })
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(destination: GoodPointView(viewModel: GoodPointViewModel(topic: viewModel.topic)),
                       isActive: $viewModel.showingGoodPointView) {
          Button(action: {
            viewModel.next()
          }) {
            Text("NextButton".localized())
              .foregroundColor(.appPointColor)
          }
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
    .navigationTitle(Text("WriteTitle".localized()))
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}

extension WriteView {
  var topicLabel: some View {
    Text("WriteViewTopicTitle".localized())
      .foregroundColor(.appTextColor)
  }
  
  var topicTextField: some View {
    TextField("WriteViewTopicExample".localized(), text: $viewModel.topic, onCommit: {
      viewModel.next()
    })
      .focused($focused)
      .typeFieldStyle()
  }
}
