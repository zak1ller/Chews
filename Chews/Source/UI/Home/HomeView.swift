//
//  ContentView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import SwiftUI
import Introspect

struct HomeView: View {
  @State private var showingWriteView = false
  @State private var uiTabBarController: UITabBarController?
  
  var body: some View {
    NavigationView {
      VStack {
        question
        Spacer().frame(height: 24)
        writeButton
      }
      .navigationBarTitleDisplayMode(.inline)
      .introspectTabBarController { (UITabBarController) in
        self.uiTabBarController = UITabBarController
      }
      .onAppear {
        self.uiTabBarController?.tabBar.isHidden = false
      }
    }
  }
}

extension HomeView {
  var question: some View {
    HStack {
      Spacer().frame(width: 16)
      Text("HomeViewTopicTitle".localized())
        .foregroundColor(.appTextColor)
        .multilineTextAlignment(.center)
      Spacer().frame(width: 16)
    }
  }
  
  var writeButton: some View {
    HStack {
      Spacer().frame(width: 16)
      NavigationLink(destination: WriteView(firstViewActive: $showingWriteView),
                     isActive: $showingWriteView) {
        BigButton(title: "HomeViewContentTitle".localized(), tappedAction: {
          self.showingWriteView = true
        })
      }
      Spacer().frame(width: 16)
    }
  }
}
