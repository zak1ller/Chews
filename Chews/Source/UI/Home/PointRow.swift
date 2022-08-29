//
//  GoodPointRow.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/04.
//

import Foundation
import SwiftUI

struct PointRow: View {
  let point: String
  let deleteButtonTappedAction: (() -> ())?
  
  var body: some View {
    VStack {
      HStack {
        contentText
        Spacer()
        Button(action: {
          self.deleteButtonTappedAction?()
        }) {
         deleteButton
        }
        .frame(width: 24, height: 24)
      }
    }
    .listRowSeparator(.hidden)
    .listRowInsets(EdgeInsets())
    .fixedSize(horizontal: false, vertical: true)
    .cornerRadius(4)
    .padding(.bottom, 2)
  }
}

extension PointRow {
  var contentText: some View {
    Text(point)
      .font(.system(size: 14, weight: .medium))
      .foregroundColor(.appTextColor)
      .padding(.leading, 16)
      .padding(.trailing, 16)
      .padding(.top, 8)
      .padding(.bottom, 8)
  }
  
  var deleteButton: some View {
    Circle()
      .foregroundColor(.appTextSubColor)
      .overlay {
        Image(systemName: "minus")
          .foregroundColor(.appBackgroundColor)
          .font(.system(size: 16))
      }
  }
}
