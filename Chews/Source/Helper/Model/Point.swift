//
//  Point.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/09.
//

import Foundation
import RealmSwift
import IceCream

final class Point: Object {
  @objc dynamic var id: String!
  @objc dynamic var title = ""
  @objc dynamic var score = 1
  @objc dynamic var isDeleted: Bool = false
  override class func primaryKey() -> String? {
    return "id"
  }
}

extension Point: Identifiable {}

extension Point: CKRecordConvertible & CKRecordRecoverable {}

extension Point {
  func edit(title: String) {
    try! Realm().write {
      self.title = title
    }
  }
  
  func increaseScore() {
    try! Realm().write {
      if score < 5 {
        score += 1
      } else {
        score = 1
      }
    }
  }
}
