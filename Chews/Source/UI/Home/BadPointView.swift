//
//  BadPointView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct BadPointView: View {
  var topic: String
  @Binding var goodPoints: [Point]
  @Binding var firstViewActive: Bool
  @State var latestCount = 0
  @State private var badPointValue = ""
  @State private var badPoints: [Point] = []
  @State private var errorMessage = ""
  @State private var showingErrorMessage = false
  @State private var showingResultView = false
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
        self.focused = true
      }
    }
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        NavigationLink(destination: ResultView(topic: topic,
                                               firstViewActive: $firstViewActive,
                                               goodPoints: $goodPoints,
                                               badPoints: $badPoints),
                       isActive: $showingResultView) {
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

extension BadPointView {
  var badPointLabel: some View {
    Text("BadPointMessage".localized())
      .foregroundColor(.appTextColor)
      .multilineTextAlignment(.center)
  }
  
  var badPointTextField: some View {
    TextField(topic, text: $badPointValue, onCommit: {
      enter()
    })
    .focused($focused)
    .typeFieldStyle()
  }
  
  var listView: some View {
    ScrollViewReader{ proxy in
      ScrollView(.vertical, showsIndicators: false) {
        VStack {
          ForEach(0..<badPoints.count, id: \.self) { i in
            PointRow(point: "\(self.badPoints[i].title)") {
              self.badPoints.remove(at: i)
            }
            .id(i)
          }
        }
        .onChange(of: badPoints.count) { count in
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

extension BadPointView {
  func enter() {
    if badPointValue.count == 0 {
      errorMessage = "ContentTooShort".localized()
      showingErrorMessage = true
    } else {
      let point = Point()
      point.title = badPointValue
      badPoints.append(point)
      badPointValue = ""
      focused = true
    }
  }
  
  func next() {
    if badPoints.isEmpty {
      errorMessage = "BadPointEmptyMessage".localized()
      showingErrorMessage = true
    } else {
      showingResultView = true
    }
  }
}
