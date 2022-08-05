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
    VStack {
      Spacer().frame(height: 16)
      HStack {
        contentText
        Spacer()
      }
      Spacer().frame(height: 16)
    }
    .background(Color.appBackgroundSubColor)
    .listRowSeparator(.hidden)
    .listRowInsets(EdgeInsets())
    .fixedSize(horizontal: false, vertical: true)
    .cornerRadius(4)
    .padding(.bottom, 16)
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}

extension ResultRow {
  var contentText: some View {
    HStack {
      Text(point)
        .font(.system(size: 14, weight: .regular))
        .foregroundColor(.appTextColor)
    }
    .padding(.leading, 16)
    .padding(.trailing, 16)
  }
}
