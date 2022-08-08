//
//  ResultRow.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct TopicRow: View {
  var tappedAction: (() -> ())?
                     
  @Binding var point: Point
  @State private var scoreTextValue = ""
  
  var body: some View {
    VStack {
      Spacer().frame(height: 16)
      HStack {
        contentText
        Spacer()
      }
      Spacer().frame(height: 16)
    }
    .onAppear {
      scoreTextValue = "\(point.score)"
    }
    .background(Color.appBackgroundSubColor)
    .listRowSeparator(.hidden)
    .listRowInsets(EdgeInsets())
    .fixedSize(horizontal: false, vertical: true)
    .cornerRadius(4)
    .padding(.horizontal, 16)
    .padding(.bottom, 16)
    .onTapGesture {
      if point.score < 5 {
        point.score += 1
      } else {
        point.score = 1
      }
      scoreTextValue = "\(point.score)"
      tappedAction?()
    }
  }
}

extension TopicRow {
  var contentText: some View {
    HStack {
      Text(point.title)
        .font(.system(size: 14, weight: .regular))
        .foregroundColor(.appTextColor)
      +
      Text(" ")
      +
      Text(scoreTextValue)
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(.appPointColor)
    
    }
    .padding(.horizontal, 16)
  }
  
  var scoreText: some View {
    Text(scoreTextValue)
      .foregroundColor(Color.appPointColor)
      .font(.system(size: 12, weight: .medium))
      .padding(.horizontal, 16)
  }
}
