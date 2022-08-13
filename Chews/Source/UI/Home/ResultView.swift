//
//  ResultView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct ResultView: View {
  @ObservedObject var viewModel: ResultViewModel
  @EnvironmentObject var homeViewModel: HomeViewModel
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      resultTitleLabel
      Spacer().frame(height: 24)
      topicLabel
      Spacer().frame(height: 24)
      listView
      
      NavigationLink(destination: ResultPointEditView(
        point: viewModel.isSelectedGoodPoint ? $viewModel.goodPoints[viewModel.selectedIndex] : $viewModel.badPoints[viewModel.selectedIndex],
        index: viewModel.selectedIndex),
                     isActive: $viewModel.showingPointEditView) {
        EmptyView()
      }
      NavigationLink(destination: ResultPointAddView(points: viewModel.isSelectedGoodPoint ? $viewModel.goodPoints : $viewModel.badPoints),
                     isActive: $viewModel.showingPointAddView) {
        EmptyView()
      }
    }
    .onAppear {
      viewModel.hiddenTrigger.toggle()
      viewModel.updateScore()
    }
    .edgesIgnoringSafeArea(.bottom)
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button(action: {
          homeViewModel.shwoingWriteView = viewModel.finish()
        }) {
          Text(viewModel.hiddenTrigger ? "FinishButton".localized() : "FinishButton".localized())
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
    Text(viewModel.topic)
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
          ForEach(0..<viewModel.goodPoints.count, id: \.self) { i in
            TopicRow(isHistory: false,
                     point: viewModel.goodPoints[i],
                     tappedAction: {
              viewModel.updateScore()
            })
              .contextMenu {
                Button(action: {
                  viewModel.edit(i, pointType: .good)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  viewModel.delete(i, pointType: .good)
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
          ForEach(0..<viewModel.badPoints.count, id: \.self) { i in
            TopicRow(isHistory: false,
                     point: viewModel.badPoints[i],
                     tappedAction: {
              viewModel.updateScore()
            })
              .contextMenu {
                Button(action: {
                  viewModel.edit(i, pointType: .bad)
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  viewModel.delete(i, pointType: .bad)
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

