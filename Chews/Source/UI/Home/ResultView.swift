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
  @Binding var goodPoints: [String]
  @Binding var badPoints: [String]
  @State private var isSelectedGoodPoint = false
  @State private var showingFinishAlert = false
  @State private var selectedIndex = 0
  @State private var showingPointEditView = false
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      resultTitleLabel
      Spacer().frame(height: 24)
      topicLabel
      Spacer().frame(height: 24)
      listView
      NavigationLink(destination: ResultPointEditView(points: isSelectedGoodPoint ? $goodPoints : $badPoints,
                                                      uiTabarController: $uiTabarController,
                                                      index: selectedIndex),
                     isActive: $showingPointEditView) {
        EmptyView()
      }
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
          HStack {
            Spacer().frame(width: 16)
            Text("GoodPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(0..<goodPoints.count, id: \.self) { i in
            TopicRow(point: self.goodPoints[i])
              .contextMenu {
                Button(action: {
                  self.editGoodPoint(i: i)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.deleteGoodPoint(i: i)
                }, label: {
                  Label("DeleteButton".localized(), systemImage: "minus.circle")
                })
              }
          }
          Spacer().frame(height: 24)
        }
        ScrollView {
          HStack {
            Spacer().frame(width: 16)
            Text("BadPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(0..<badPoints.count, id: \.self) { i in
            TopicRow(point: self.badPoints[i])
              .contextMenu {
                Button(action: {
                  self.editBadPoint(i: i)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.deleteBadPoint(i: i)
                }, label: {
                  Label("DeleteButton".localized(), systemImage: "minus.circle")
                })
              }
          }
          Spacer().frame(height: 24)
        }
      }
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
  
  func editGoodPoint(i: Int) {
    isSelectedGoodPoint = true
    selectedIndex = i
    showingPointEditView = true
  }
  
  func editBadPoint(i: Int) {
    isSelectedGoodPoint = false
    selectedIndex = i
    showingPointEditView = true
  }
  
  func deleteGoodPoint(i: Int) {
    goodPoints.remove(at: i)
  }
  
  func deleteBadPoint(i: Int) {
    badPoints.remove(at: i)
  }
}
