//
//  Topic.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import RealmSwift
import IceCream

final class Topic: Object {
  @objc dynamic var id: String!
  @objc dynamic var topic = ""
  var goodPoints: List<Point> = List<Point>()
  var badPoints: List<Point> = List<Point>()
  @objc dynamic var date: Date = Date()
  @objc dynamic var isDeleted: Bool = false
  
  override class func primaryKey() -> String? {
    return "id"
  }
}

extension Topic: Identifiable {}

extension Topic: CKRecordConvertible & CKRecordRecoverable {}

extension Topic {
  static func add(topic: String, goodPoints: [Point], badPoints: [Point]) {
    let data = Topic()
    data.id = UUID().uuidString
    data.topic = topic
    
    for value in goodPoints {
      value.id = UUID().uuidString
      data.goodPoints.append(value)
    }
    
    for value in badPoints {
      value.id = UUID().uuidString
      data.badPoints.append(value)
    }
    
    try! Realm().write {
      try! Realm().add(data)
    }
  }
  
  static func get() -> [Topic] {
    let results = try! Realm().objects(Topic.self)
      .sorted(byKeyPath: "date", ascending: false)
      .filter("isDeleted = false")
    
    var topics: [Topic] = []
    for value in results {
      topics.append(value)
    }
    
    return topics
  }
  
  static func delete(topic: Topic) {
    try! Realm().write {
      topic.isDeleted = true
    }
  }
  
  func addPoint(text: String, pointType: PointType) {
//    try! Realm().write {
//      switch pointType {
//      case .good:
//        self.goodPoints.append(text)
//      case .bad:
//        self.badPoints.append(text)
//      }
//    }
  }
  
  func deletePoint(point: String, pointType: PointType) {
//    try! Realm().write {
//      switch pointType {
//      case .good:
//        var i = 0
//        for value in goodPoints {
//          if value == point {
//            goodPoints.remove(at: i)
//          } else {
//            i += 1
//          }
//        }
//      case .bad:
//        var i = 0
//        for value in badPoints {
//          if value == point {
//            badPoints.remove(at: i)
//          } else {
//            i += 1
//          }
//        }
//      }
//    }
  }
  
  func editPoint(to text: String, pointType: PointType, i: Int) {
//    try! Realm().write {
//      switch pointType {
//      case .good:
//        goodPoints[i] = text
//      case .bad:
//        badPoints[i] = text
//      }
//    }
  }
}
