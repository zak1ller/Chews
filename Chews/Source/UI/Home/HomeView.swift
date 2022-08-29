//
//  ContentView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import SwiftUI
import Introspect

struct HomeView: View {
  @EnvironmentObject var viewModel: HomeViewModel
  
  var body: some View {
    NavigationView {
      VStack {
        question
        Spacer().frame(height: 24)
        writeButton
      }
      .navigationBarTitleDisplayMode(.inline)
      .introspectTabBarController { (UITabBarController) in
        viewModel.uiTabBarController = UITabBarController
      }
      .onAppear {
        viewModel.uiTabBarController?.tabBar.isHidden = false
      }
    }
    .navigationViewStyle(.stack)
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
      NavigationLink(destination: WriteView(),
                     isActive: $viewModel.shwoingWriteView) {
        BigButton(title: "HomeViewContentTitle".localized(), tappedAction: {
          viewModel.shwoingWriteView = true
        })
      }
      Spacer().frame(width: 16)
    }
  }
}
