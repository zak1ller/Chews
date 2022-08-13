//
//  GoodPointView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import Foundation
import SwiftUI
import Introspect

struct GoodPointView: View {
  @ObservedObject var viewModel: GoodPointViewModel
  @FocusState private var focused: Bool
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      goodPointLabel
      goodPointTextField
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
        NavigationLink(destination: BadPointView(viewModel: BadPointViewModel(topic: viewModel.topic,
                                                                              goodPoints: viewModel.goodPoints)),
                       isActive: $viewModel.showingBadPointView) {
          Button(action: {
            focused = viewModel.next()
          }) {
            Text("NextButton".localized())
              .foregroundColor(.appPointColor)
          }
        }
      }
    }
    .alert("AlertTitle".localized(), isPresented: $viewModel.showingErrorMessage, actions: {
      Button("ConfirmButton".localized(), role: .cancel) {
        focused = viewModel.alertConfirmButtonTapped()
      }
    }, message: {
      Text(viewModel.errorMessage)
    })
  }
}

extension GoodPointView {
  var goodPointLabel: some View {
    Text("GoodPointMessage".localized())
      .foregroundColor(.appTextColor)
      .multilineTextAlignment(.center)
  }
  
  var goodPointTextField: some View {
    TextField(viewModel.topic, text: $viewModel.goodPointValue, onCommit: {
      focused = viewModel.enter()
    })
    .focused($focused)
    .typeFieldStyle()
  }
  
  var listView: some View {
    ScrollViewReader{ proxy in
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(0..<viewModel.goodPoints.count, id: \.self) { i in
            PointRow(point: "\(viewModel.goodPoints[i].title)") {
              viewModel.removePoint(at: i)
            }
            .id(i)
          }
        }
        .onChange(of: viewModel.goodPoints.count) { count in
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
