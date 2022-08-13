//
//  HomeViewModel.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/12.
//

import Foundation
import SwiftUI

final class HomeViewModel: ObservableObject {
  @Published var shwoingWriteView = false
  @Published var uiTabBarController: UITabBarController?
}
