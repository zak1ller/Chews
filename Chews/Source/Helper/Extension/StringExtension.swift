//
//  SreinfExtension.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/01.
//

import Foundation

extension String {
  func localized(comment: String = "") -> String {
    return NSLocalizedString(self, comment: comment)
  }
}
