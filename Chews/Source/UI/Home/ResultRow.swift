//
//  ResultRow.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import SwiftUI

struct ResultRow: View {
  let index: Int
  let point: String
  
  var body: some View {
    HStack {
      contentText
      Spacer()
    }
    .listRowSeparator(.hidden)
    .listRowInsets(EdgeInsets())
    .fixedSize(horizontal: false, vertical: true)
    .cornerRadius(4)
  }
}

extension ResultRow {
  var contentText: some View {
    HStack {
      Text("\(index + 1). ")
        .font(.system(size: 14, weight: .regular))
        .foregroundColor(.appTextSubColor) +
      Text(point)
        .font(.system(size: 14, weight: .regular))
        .foregroundColor(.appTextColor)
    }
    .padding(.leading, 16)
    .padding(.trailing, 16)
    .padding(.bottom, 8)
  }
}
