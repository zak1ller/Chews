//
//  HistoryRow.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct HistoryRow: View {
  let topic: Topic
  
  var body: some View {
    HStack {
      contentText
      Spacer()
      Image(systemName: "chevron.right")
        .foregroundColor(.appTextSubColor)
    }
    .padding(.leading, 16)
    .padding(.trailing, 16)
    .padding(.bottom, 24)
  }
}

extension HistoryRow {
  var contentText: some View {
    Text(topic.topic)
      .foregroundColor(.appTextSubColor)
      .multilineTextAlignment(.leading)
  }
}
