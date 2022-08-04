//
//  TypeFieldModifier.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/04.
//

import Foundation
import SwiftUI

struct TypeFieldViewModifier: ViewModifier {
  func body(content: Content) -> some View {
    content
      .textFieldStyle(.plain)
      .multilineTextAlignment(.center)
      .frame(height: 48)
      .background(Color.appBackgroundSubColor)
      .cornerRadius(4)
      .font(.system(size: 14))
  }
}

extension View {
  func typeFieldStyle() -> some View {
    modifier(TypeFieldViewModifier())
  }
}
