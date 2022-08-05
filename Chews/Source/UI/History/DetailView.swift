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

struct DetailView: View {
  @Binding var topic: Topic
  @Binding var topics: [Topic]
  @Binding var activeDetailView: Bool
  @State private var uiTabarController: UITabBarController?
  @State private var deleteGoodPoint = ""
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      topicLabel
      Spacer().frame(height: 24)
      listView
    }
    .introspectTabBarController { (UITabBarController) in
      UITabBarController.tabBar.isHidden = true
      uiTabarController = UITabBarController
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

extension DetailView {
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
          HStack {
            Spacer().frame(width: 16)
            Text("GoodPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(topic.goodPoints, id: \.self) { goodPoint in
            ResultRow(index: 0, point: goodPoint)
              .contextMenu {
                Button(action: {
                  
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.deleteGoodPoint = goodPoint
                  self.deleteGoodPoint(goodPoint)
                }, label: {
                  Label("DeleteButton".localized(), systemImage: "minus.circle")
                })
              }
          }
          Spacer().frame(height: 24)
        }
        ScrollView {
          HStack {
            Spacer().frame(width: 16)
            Text("BadPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(topic.badPoints, id: \.self) { badPoint in
            ResultRow(index: 0, point: badPoint)
              .contextMenu {
                Button(action: {
                  
                }, label: {
                  Label("EditButton".localized(), systemImage: "square.and.pencil")
                })
                Button(action: {
                  self.deleteBadPoint(badPoint)
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

extension DetailView {
  func delete() {
    Topic.delete(topic: topic)
    topics = Topic.get()
    activeDetailView = false
  }
  
  func deleteGoodPoint(_ goodPoint: String) {
    Topic.deleteGootPoint(topic: topic, goodPoint: goodPoint)
    topics = Topic.get()
  }
  
  func deleteBadPoint(_ badPoint: String) {
    Topic.deleteBadPoint(topic: topic, badPoint: badPoint)
    topics = Topic.get()
  }
}
