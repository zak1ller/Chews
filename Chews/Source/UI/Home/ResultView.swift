//
//  ResultView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct ResultView: View {
  var topic: String
  @Binding var firstViewActive: Bool
  @Binding var uiTabarController: UITabBarController?
  @State var goodPoints: [String]
  @State var badPoints: [String]
  @State var showingFinishAlert = false
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      resultTitleLabel
      Spacer().frame(height: 24)
      topicLabel
      Spacer().frame(height: 24)
      listView
    }
    .onAppear {
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
        uiTabarController?.tabBar.isHidden = true
      }
    }
    .onDisappear {
      uiTabarController?.tabBar.isHidden = false
    }
    .edgesIgnoringSafeArea(.bottom)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          finish()
        }) {
          Text("FinishButton".localized())
            .foregroundColor(.appPointColor)
        }
      }
    }
  }
}

extension ResultView {
  var resultTitleLabel: some View {
    Text("ResultViewTitle".localized())
      .foregroundColor(.appTextColor)
      .multilineTextAlignment(.center)
      .padding(.leading, 16)
      .padding(.trailing, 16)
  }
  
  var topicLabel: some View {
    Text(topic)
      .foregroundColor(.appTextSubColor)
      .font(.system(size: 14, weight: .medium))
      .multilineTextAlignment(.center)
      .padding(.leading, 16)
      .padding(.trailing, 16)
  }
  
  var listView: some View {
    ZStack {
      HStack {
        ScrollView {
          Spacer().frame(height: 16)
          HStack {
            Spacer().frame(width: 16)
            Text("GoodPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(0..<goodPoints.count, id: \.self) { i in
            ResultRow(index: i, point: self.goodPoints[i])
          }
          Spacer().frame(height: 24)
        }
        ScrollView {
          Spacer().frame(height: 16)
          HStack {
            Spacer().frame(width: 16)
            Text("BadPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(0..<badPoints.count, id: \.self) { i in
            ResultRow(index:  i, point: self.badPoints[i])
          }
          Spacer().frame(height: 24)
        }
      }
      .background(Color.appBackgroundSubColor)
      .cornerRadius(4)
      HStack {
        Spacer()
        Rectangle()
          .frame(maxWidth: 1, maxHeight: .infinity)
          .foregroundColor(Color.appDividerColor)
        Spacer()
      }
    }
  }
}

extension ResultView {
  func finish() {
    Topic.add(topic: topic,
              goodPoints: goodPoints,
              badPoints: badPoints)
    firstViewActive = false
  }
}
