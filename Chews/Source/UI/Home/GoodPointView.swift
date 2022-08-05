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
  var topic: String
  @Binding var firstViewActive: Bool
  @Binding var uiTabarController: UITabBarController?
  @FocusState private var focused: Bool
  @State var latestCount = 0
  @State private var goodPointValue = ""
  @State private var errorMessage = ""
  @State private var showingErrorMessage = false
  @State private var showingBadPointView = false
  @State private var goodPoints: [String] = []
  
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
        self.focused = true
        self.uiTabarController?.tabBar.isHidden = true
      }
    }
    .onDisappear {
      self.uiTabarController?.tabBar.isHidden = false
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(destination: BadPointView(topic: topic,
                                                 goodPoints: goodPoints,
                                                 firstViewActive: $firstViewActive,
                                                 uiTabarController: $uiTabarController),
                       isActive: $showingBadPointView) {
          Button(action: {
            next()
          }) {
            Text("NextButton".localized())
              .foregroundColor(.appPointColor)
          }
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

extension GoodPointView {
  var goodPointLabel: some View {
    Text("GoodPointMessage".localized())
      .foregroundColor(.appTextColor)
      .multilineTextAlignment(.center)
  }
  
  var goodPointTextField: some View {
    TextField(topic, text: $goodPointValue, onCommit: {
      enter()
    })
    .focused($focused)
    .typeFieldStyle()
  }
  
  var listView: some View {
    ScrollViewReader{ proxy in
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(0..<goodPoints.count, id: \.self) { i in
            PointRow(point: "\(self.goodPoints[i])") {
              self.goodPoints.remove(at: i)
            }
            .id(i)
          }
        }
        .onChange(of: goodPoints.count) { count in
          if latestCount < count {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
              withAnimation {
                proxy.scrollTo(count - 1)
              }
            }
          }
          self.latestCount = count
        }
      }
    }
  }
}

extension GoodPointView {
  func enter() {
    if goodPointValue.count == 0 {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      goodPoints.append(goodPointValue)
      goodPointValue = ""
      focused = true
    }
  }
  
  func next() {
    if goodPoints.isEmpty {
      errorMessage = "GoodPointsEmptyMessage".localized()
      showingErrorMessage = true
    } else {
      showingBadPointView = true
    }
  }
}
