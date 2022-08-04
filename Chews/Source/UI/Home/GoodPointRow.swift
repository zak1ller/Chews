//
//  GoodPointRow.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/04.
//

import Foundation
import SwiftUI

struct GoodPointRow: View {
  let goodPoint: String
  let deleteButtonTappedAction: (() -> ())?
  
  var body: some View {
    VStack {
      HStack {
        contentText
        Spacer()
        Button(action: {
          self.deleteButtonTappedAction?()
        }) {
          Circle()
            .foregroundColor(.red)
            .overlay {
              Image(systemName: "minus")
                .foregroundColor(.white)
                .font(.system(size: 16))
            }
        }
        .frame(width: 24, height: 24)
      }
    }
    .listRowSeparator(.hidden)
    .listRowInsets(EdgeInsets())
    .fixedSize(horizontal: false, vertical: true)
//    .background(Color.appBackgroundSubColor)
    .cornerRadius(4)
    .padding(.bottom, 2)
  }
}

extension GoodPointRow {
  var contentText: some View {
    Text(goodPoint)
      .font(.system(size: 14, weight: .medium))
      .foregroundColor(.appTextColor)
      .padding(.leading, 16)
      .padding(.trailing, 16)
      .padding(.top, 8)
      .padding(.bottom, 8)
  }
}
