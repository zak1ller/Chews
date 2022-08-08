//
//  HistoryView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI
import Introspect

struct HistoryView: View {
  @State private var topics = Topic.get()
  @State private var showingDetail = false
  @State private var selectedTopic: Topic = Topic()
  @State private var selectedIndex: Int = 0
  @State private var uiTabBarController: UITabBarController?
  
  var body: some View {
    NavigationView {
      VStack {
        listView
      }
      .onAppear {
        self.uiTabBarController?.tabBar.isHidden = false
        self.topics = Topic.get()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
          self.topics = Topic.get()
        })
      }
      .introspectTabBarController { (UITabBarController) in
        self.uiTabBarController = UITabBarController
      }
      .navigationTitle("TabBarItemHistory".localized())
      .navigationBarTitleDisplayMode(.large)
    }
  }
}

extension HistoryView {
  var listView: some View {
    ScrollView(.vertical) {
      NavigationLink(destination: HistoryDetailView(topic: $selectedTopic,
                                                    topics: $topics,
                                                    activeDetailView: $showingDetail),
                     isActive: $showingDetail) {
        
      }
      Spacer().frame(height: 24)
      ForEach(topics) { topic in
        HistoryRow(topic: topic)
          .background(Color.appBackgroundColor)
          .onTapGesture {
            openDetailView(topic: topic)
          }
      }
    }
  }
}

extension HistoryView {
  func openDetailView(topic: Topic) {
    self.selectedTopic = topic
    self.showingDetail = true
  }
}
