//
//  Topic.swift
//  Chews
//
//  Created by Min-Su Kim on 2022/08/05.
//

import Foundation
import RealmSwift

final class Topic: Object {
  @objc dynamic let id = UUID()
  @objc dynamic var topic = ""
  var goodPoints: List<String> = List<String>()
  var badPoints: List<String> = List<String>()
  @objc dynamic var date: Date = Date()
  @objc dynamic var isDeleted: Bool = false
}

extension Topic: Identifiable {}

extension Topic {
  static func deleteGootPoint(topic: Topic, goodPoint: String) {
    var i = 0
    for value in topic.goodPoints {
      if value == goodPoint {
        break
      }
      i += 1
    }
    
    try! Realm().write {
      topic.goodPoints.remove(at: i)
    }
  }
  
  static func deleteBadPoint(topic: Topic, badPoint: String) {
    var i = 0
    for value in topic.badPoints {
      if value == badPoint {
        break
      }
      i += 1
    }
    
    try! Realm().write {
      topic.badPoints.remove(at: i)
    }
  }
  
  static func add(topic: String, goodPoints: [String], badPoints: [String]) {
    let data = Topic()
    data.topic = topic
    
    for value in goodPoints {
      data.goodPoints.append(value)
    }
    
    for value in badPoints {
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
}
