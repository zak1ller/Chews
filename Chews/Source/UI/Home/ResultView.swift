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
  @Binding var goodPoints: [Point]
  @Binding var badPoints: [Point]
  @State private var isSelectedGoodPoint = false
  @State private var showingFinishAlert = false
  @State private var selectedIndex = 0
  @State private var showingPointEditView = false
  @State private var showingPointAddView = false
  @State private var hiddenTrigger = false
  @State private var goodPointScore = ""
  @State private var badPointScore = ""
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      resultTitleLabel
      Spacer().frame(height: 24)
      topicLabel
      Spacer().frame(height: 24)
      listView
      NavigationLink(destination: ResultPointEditView(
        point: isSelectedGoodPoint ? $goodPoints[selectedIndex] : $badPoints[selectedIndex],
                                                      index: selectedIndex),
                     isActive: $showingPointEditView) {
        EmptyView()
      }
      NavigationLink(destination: ResultPointAddView(points: isSelectedGoodPoint ? $goodPoints : $badPoints),
                     isActive: $showingPointAddView) {
        EmptyView()
      }
    }
    .onAppear {
      hiddenTrigger.toggle()
      updateScore()
    }
    .edgesIgnoringSafeArea(.bottom)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          finish()
        }) {
          Text(hiddenTrigger ? "FinishButton".localized() : "FinishButton".localized())
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
          HStack(alignment: .center) {
            Spacer().frame(width: 16)
            Text("GoodPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer().frame(width: 4)
            Text(goodPointScore)
              .foregroundColor(.appPointColor)
            Spacer()
            ZStack {
              Button(action: {
                add(pointType: .good)
              }) {
                HStack {
                  Spacer()
                  Image(systemName: "plus.circle.fill")
                    .foregroundColor(.appTextSubColor)
                }
              }
              .frame(width: 32, height: 32)
            }
            Spacer().frame(width: 16)
          }
          Spacer().frame(height: 16)
          ForEach(0..<goodPoints.count, id: \.self) { i in
            TopicRow(tappedAction: {
              self.updateScore()
            },
                     point: self.$goodPoints[i])
              .contextMenu {
                Button(action: {
                  self.edit(i, pointType: .good)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.delete(i, pointType: .good)
                }, label: {
                  Label("DeleteButton".localized(), systemImage: "minus.circle")
                })
              }
          }
          Spacer().frame(height: 24)
        }
        ScrollView {
          HStack(alignment: .center) {
            Spacer().frame(width: 16)
            Text("BadPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer().frame(width: 4)
            Text(badPointScore)
              .foregroundColor(.appPointColor)
            Spacer()
            ZStack {
              Button(action: {
                add(pointType: .bad)
              }) {
                HStack {
                  Spacer()
                  Image(systemName: "plus.circle.fill")
                    .foregroundColor(.appTextSubColor)
                }
              }
              .frame(width: 32, height: 32)
            }
            Spacer().frame(width: 16)
          }
          Spacer().frame(height: 16)
          ForEach(0..<badPoints.count, id: \.self) { i in
            TopicRow(tappedAction: {
              self.updateScore()
            } ,point: self.$badPoints[i])
              .contextMenu {
                Button(action: {
                  self.edit(i, pointType: .bad)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.delete(i, pointType: .bad)
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
  
  func updateScore() {
    var value = 0
    goodPoints.forEach {
      value += $0.score
    }
    goodPointScore = "\(value)"
    
    value = 0
    badPoints.forEach {
      value += $0.score
    }
    badPointScore = "\(value)"
  }
  
  func add(pointType: PointType) {
    switch pointType {
    case .good:
      isSelectedGoodPoint = true
    case .bad:
      isSelectedGoodPoint = false
    }
    showingPointAddView = true
  }
  
  func edit(_ i: Int, pointType: PointType) {
    switch pointType {
    case .good:
      isSelectedGoodPoint = true
    case .bad:
      isSelectedGoodPoint = false
    }
    selectedIndex = i
    showingPointEditView = true
  }
  
  func delete(_ i: Int, pointType: PointType) {
    switch pointType {
    case .good:
      goodPoints.remove(at: i)
    case .bad:
      badPoints.remove(at: i)
    }
  }
}
