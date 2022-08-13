//
//  BadPointView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct BadPointView: View {
  @ObservedObject var viewModel: BadPointViewModel
  @FocusState private var focused: Bool
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      badPointLabel
      badPointTextField
      Spacer().frame(height: 16)
      listView
      Spacer()
    }
    .padding(.leading, 16)
    .padding(.trailing, 16)
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        focused = true
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(destination: ResultView(viewModel: ResultViewModel(topic: viewModel.topic,
                                                                          goodPoints: viewModel.goodPoints,
                                                                          badPoints: viewModel.badPoints)),
                       isActive: $viewModel.showingResultView) {
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
  }
}

extension BadPointView {
  var badPointLabel: some View {
    Text("BadPointMessage".localized())
      .foregroundColor(.appTextColor)
      .multilineTextAlignment(.center)
  }
  
  var badPointTextField: some View {
    TextField(viewModel.topic, text: $viewModel.badPointValue, onCommit: {
      focused = viewModel.enter()
    })
    .focused($focused)
    .typeFieldStyle()
  }
  
  var listView: some View {
    ScrollViewReader{ proxy in
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(0..<viewModel.badPoints.count, id: \.self) { i in
            PointRow(point: "\(viewModel.badPoints[i].title)") {
              self.viewModel.badPoints.remove(at: i)
            }
            .id(i)
          }
        }
        .onChange(of: viewModel.badPoints.count) { count in
          if viewModel.latestCount < count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
              withAnimation {
                proxy.scrollTo(count - 1)
              }
            }
          }
          viewModel.latestCount = count
        }
      }
    }
  }
}
  
