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
        viewModel.topics = Topic.get()
        viewModel.uiTabBarController?.tabBar.isHidden = false
      }
      .introspectTabBarController { (UITabBarController) in
        viewModel.uiTabBarController = UITabBarController
      }
      .navigationTitle("TabBarItemHistory".localized())
      .navigationBarTitleDisplayMode(.large)
    }
    .navigationViewStyle(.stack)
  }
}

extension HistoryView {
  var listView: some View {
    ScrollView(.vertical) {
      NavigationLink(destination: HistoryDetailView(viewModel: HistoryDetailViewModel(topic: $viewModel.selectedTopic,
                                                                                      activeDetailView: $viewModel.showingDetailView)),
                     isActive: $viewModel.showingDetailView) {
        EmptyView()
      }
      Spacer().frame(height: 24)
      ForEach(viewModel.topics) { topic in
        HistoryRow(topic: topic)
          .background(Color.appBackgroundColor)
          .onTapGesture {
            viewModel.openDetailView(topic: topic)
          }
      }
    }
  }
}
