//
//  DetailView.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct DetailView: View {
  @Binding var topic: Topic
  @Binding var activeDetailView: Bool
  
  var body: some View {
    VStack {
      Spacer().frame(height: 24)
      topicLabel
      Spacer().frame(height: 24)
      listView
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
          Spacer().frame(height: 16)
          HStack {
            Spacer().frame(width: 16)
            Text("GoodPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(0..<topic.goodPoints.count, id: \.self) { i in
            ResultRow(index: i, point: self.topic.goodPoints[i])
          }
          Spacer().frame(height: 24)
        }
        ScrollView {
          Spacer().frame(height: 16)
          HStack {
            Spacer().frame(width: 16)
            Text("BadPoints".localized())
              .foregroundColor(.appTextSubColor)
            Spacer()
          }
          Spacer().frame(height: 16)
          ForEach(0..<topic.badPoints.count, id: \.self) { i in
            ResultRow(index:  i, point: self.topic.badPoints[i])
          }
          Spacer().frame(height: 24)
        }
      }
      .background(Color.appBackgroundSubColor)
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
    activeDetailView = false
  }
}
