//
//  DetailView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI
import Introspect
import RealmSwift

struct HistoryDetailView: View {
  @Binding var topic: Topic
  @Binding var topics: [Topic]
  @Binding var activeDetailView: Bool
  @State private var showingPointEditView = false
  @State private var showingPointAddView = false
  @State private var selectedPoint: Point = Point()
  @State private var selectedPointType: PointType = .good
  @State private var hiddenTrigger = false
  @State private var goodPointScore = ""
  @State private var badPointScore = ""
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      NavigationLink(destination: HistoryPointEditView(point: $selectedPoint),
                     isActive: $showingPointEditView) {
        EmptyView()
      }
      NavigationLink(destination: HistoryPointAddView(pointType: selectedPointType,
                                                      topic: $topic),
                     isActive: $showingPointAddView) {
        EmptyView()
      }
      topicLabel
      Spacer().frame(height: 24)
      listView
    }
    .introspectTabBarController { (UITabBarController) in
      UITabBarController.tabBar.isHidden = true
    }
    .onAppear {
      topics.removeAll()
      topics = Topic.get()
      updateScore()
    }
    .navigationBarTitleDisplayMode(.inline)
    .edgesIgnoringSafeArea(.bottom)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          delete()
        }) {
          Text("DeleteButton".localized())
            .foregroundColor(.appPointColor)
        }
      }
    }
  }
}

extension HistoryDetailView {
  var topicLabel: some View {
    Text(topic.topic)
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
          ForEach(0..<topic.goods.count, id: \.self) { i in
            TopicRow(isHistory: true,
                     point: topic.goods[i]) {
              self.updateScore()
            }
            .contextMenu {
              Button(action: {
                self.edit(self.topic.goods[i], pointType: .good, i: i)
              }, label: {
                Label("EditButton".localized(), systemImage: "square.and.pencil")
              })
              Button(action: {
                self.delete(self.topic.goods[i].title, pointType: .good)
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
          ForEach(0..<topic.bads.count, id: \.self) { i in
            TopicRow(isHistory: true,
                     point: topic.bads[i],
                     tappedAction: {
              self.updateScore()
            })
            .contextMenu {
              Button(action: {
                self.edit(self.topic.bads[i], pointType: .bad, i: i)
              }, label: {
                Label("EditButton".localized(), systemImage: "square.and.pencil")
              })
              Button(action: {
                self.delete(self.topic.bads[i].title, pointType: .bad)
              }, label: {
                Label("DeleteButton".localized(), systemImage: "minus.circle")
              })
            }
          }
          Spacer().frame(height: 24)
        }
      }
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

extension HistoryDetailView {
  func delete() {
    Topic.delete(topic: topic)
    topics = Topic.get()
    activeDetailView = false
  }
  
  func add(pointType: PointType) {
    selectedPointType = pointType
    showingPointAddView = true
  }
  
  func edit(_ point: Point, pointType: PointType, i: Int) {
    selectedPoint = point
    selectedPointType = pointType
    showingPointEditView = true
  }
  
  func delete(_ point: String, pointType: PointType) {
    topic.deletePoint(point: point, pointType: pointType)
    topics = Topic.get()
    updateScore()
  }
  
  func updateScore() {
    var value = 0
    topic.goods.forEach {
      value += $0.score
    }
    goodPointScore = "\(value)"
    
    value = 0
    topic.bads.forEach {
      value += $0.score
    }
    badPointScore = "\(value)"
  }
}
