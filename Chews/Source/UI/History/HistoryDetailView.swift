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
  @State private var uiTabarController: UITabBarController?
  @State private var showingPointEditView = false
  @State private var showingPointAddView = false
  @State private var selectedPoint = ""
  @State private var selectedPointType: PointType = .good
  @State private var selectedPointIndex = 0
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      NavigationLink(destination: HistoryPointEditView(point: selectedPoint,
                                                pointType: selectedPointType,
                                                index: selectedPointIndex,
                                                topic: $topic,
                                                uiTabarController: $uiTabarController),
                     isActive: $showingPointEditView) {
        EmptyView()
      }
      NavigationLink(destination: HistoryPointAddView(pointType: selectedPointType,
                                                      topic: $topic,
                                                      uiTabarController: $uiTabarController),
                     isActive: $showingPointAddView) {
        EmptyView()
      }
      topicLabel
      Spacer().frame(height: 24)
      listView
    }
    .introspectTabBarController { (UITabBarController) in
      UITabBarController.tabBar.isHidden = true
      uiTabarController = UITabBarController
    }
    .onAppear {
      topics = Topic.get()
      DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
        self.uiTabarController?.tabBar.isHidden = true
      })
    }.onDisappear{
      uiTabarController?.tabBar.isHidden = false
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
          ForEach(0..<topic.goodPoints.count, id: \.self) { i in
            TopicRow(point: self.topic.goodPoints[i])
              .contextMenu {
                Button(action: {
                  self.edit(self.topic.goodPoints[i], pointType: .good, i: i)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.delete(self.topic.goodPoints[i], pointType: .good)
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
          ForEach(0..<topic.badPoints.count, id: \.self) { i in
            TopicRow(point: self.topic.badPoints[i])
              .contextMenu {
                Button(action: {
                  self.edit(self.topic.badPoints[i], pointType: .bad, i: i)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.delete(self.topic.badPoints[i], pointType: .bad)
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
  
  func edit(_ point: String, pointType: PointType, i: Int) {
    selectedPoint = point
    selectedPointType = pointType
    selectedPointIndex = i
    showingPointEditView = true
  }
  
  func delete(_ point: String, pointType: PointType) {
    topic.deletePoint(point: point, pointType: pointType)
    topics = Topic.get()
  }
}
