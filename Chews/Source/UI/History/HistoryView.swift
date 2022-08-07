//
//  HistoryView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct HistoryView: View {
  @State private var topics = Topic.get()
  @State private var showingDetail = false
  @State private var selectedTopic: Topic = Topic()
  @State private var selectedIndex: Int = 0
  
  var body: some View {
    NavigationView {
      VStack {
        listView
      }
      .navigationTitle("TabBarItemHistory".localized())
      .navigationBarTitleDisplayMode(.large)
    }
    .onAppear {
      topics = Topic.get()
    }
  }
}

extension HistoryView {
  var listView: some View {
    ScrollView(.vertical) {
      Spacer().frame(height: 24)
      ForEach(topics) { topic in
        HistoryRow(topic: topic)
          .background(Color.appBackgroundColor)
          .onTapGesture {
            openDetailView(topic: topic)
          }
      }
      NavigationLink(destination: HistoryDetailView(topic: $selectedTopic,
                                                    topics: $topics,
                                                    activeDetailView: $showingDetail),
                     isActive: $showingDetail) {
        
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
