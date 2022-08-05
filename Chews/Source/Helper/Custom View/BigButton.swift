//
//  BigButton.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import Foundation
import SwiftUI

struct BigButton: View {
  let buttonTitle: String
  let tappedAction: (() -> ())?
  
  init(title: String, tappedAction: (() -> ())? = nil) {
    self.buttonTitle = title
    self.tappedAction = tappedAction
  }
  
  var body: some View {
    Button(action: {
      self.tappedAction?()
    }) {
      Text(buttonTitle)
        .font(.system(size: 14, weight: .medium))
        .foregroundColor(.appPointColor)
        .frame(maxWidth: .infinity)
        .frame(height: 48)
    }
    .background(Color.appBackgroundSubColor)
    .cornerRadius(4)
    .clipped()
  }
}
