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
  @StateObject var viewModel: HistoryDetailViewModel
  
  var body: some View {
    VStack {
      NavigationLink(destination: HistoryPointEditView(viewModel: HistoryPointEditViewModel(point: $viewModel.selectedPoint,
                                                                                            activePointEditView: $viewModel.showingPointEditView)),
                     isActive: $viewModel.showingPointEditView) {
        EmptyView()
      }
      NavigationLink(destination: HistoryPointAddView(viewModel: HistoryPointAddViewModel(topic: $viewModel.topic,
                                                                                          pointType: viewModel.selectedPointType)),
                     isActive: $viewModel.showingPointAddView) {
        EmptyView()
      }
      Spacer().frame(height: 24)
      topicLabel
      Spacer().frame(height: 24)
      listView
    }
    .introspectTabBarController { (UITabBarController) in
      UITabBarController.tabBar.isHidden = true
    }
    .onAppear {
      viewModel.updateScore()
    }
    .navigationBarTitleDisplayMode(.inline)
    .edgesIgnoringSafeArea(.bottom)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          viewModel.delete()
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
    Text(viewModel.topic.topic)
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
            Text(viewModel.goodPointScore)
              .foregroundColor(.appPointColor)
            Spacer()
            ZStack {
              Button(action: {
                viewModel.add(pointType: .good)
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
          ForEach(0..<viewModel.topic.goods.count, id: \.self) { i in
            TopicRow(isHistory: true,
                     point: viewModel.topic.goods[i]) {
              viewModel.updateScore()
            }
            .contextMenu {
              Button(action: {
                viewModel.edit(viewModel.topic.goods[i], pointType: .good, i: i)
              }, label: {
                Label("EditButton".localized(), systemImage: "square.and.pencil")
              })
              Button(action: {
                viewModel.delete(viewModel.topic.goods[i].title, pointType: .good)
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
            Text(viewModel.badPointScore)
              .foregroundColor(.appPointColor)
            Spacer()
            ZStack {
              Button(action: {
                viewModel.add(pointType: .bad)
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
          ForEach(0..<viewModel.topic.bads.count, id: \.self) { i in
            TopicRow(isHistory: true,
                     point: viewModel.topic.bads[i],
                     tappedAction: {
              viewModel.updateScore()
            })
            .contextMenu {
              Button(action: {
                viewModel.edit(viewModel.topic.bads[i], pointType: .bad, i: i)
              }, label: {
                Label("EditButton".localized(), systemImage: "square.and.pencil")
              })
              Button(action: {
                viewModel.delete(viewModel.topic.bads[i].title, pointType: .bad)
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

