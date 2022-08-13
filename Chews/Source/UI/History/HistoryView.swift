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
  @EnvironmentObject var viewModel: HistoryViewModel
  
  var body: some View {
    NavigationView {
      VStack {
        listView
      }
      .onAppear {
        viewModel.uiTabBarController?.tabBar.isHidden = false
//        self.topics = Topic.get()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2, execute: {
          // iCloud 동기화
          viewModel.topics = Topic.get()
        })
      }
      .introspectTabBarController { (UITabBarController) in
        viewModel.uiTabBarController = UITabBarController
      }
      .navigationTitle("TabBarItemHistory".localized())
      .navigationBarTitleDisplayMode(.large)
    }
  }
}

extension HistoryView {
  var listView: some View {
    ScrollView(.vertical) {
      NavigationLink(destination: HistoryDetailView(topic: $viewModel.selectedTopic,
                                                    topics: $viewModel.topics,
                                                    activeDetailView: $viewModel.showingDetailView),
                     isActive: $viewModel.showingDetailView) {
        
      }
      Spacer().frame(height: 24)
      ForEach(viewModel.topics) { topic in
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
    viewModel.selectedTopic = topic
    viewModel.showingDetailView = true
  }
}
