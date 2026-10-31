//
//  NavigMatchTransform.swift
//  badTeacher
//
//  Created by Fedor Komov on 04.03.2026.
//

import SwiftUI

struct matchedTrans: ViewModifier {
  let matchID: String
  let IN: Namespace.ID
  func body(content: Content) -> some View {
    if #available(iOS 18.0, *) {
      content
        .matchedTransitionSource(id: matchID, in: IN)
    } else {
      // Fallback on earlier versions
      content
    }
  }
}

struct navigationTrans: ViewModifier {
  let sourceID: String
  let IN: Namespace.ID
  func body(content: Content) -> some View {
    if #available(iOS 18.0, *) {
      content
        .navigationTransition(.zoom(sourceID: sourceID, in: IN))
    } else {
      // Fallback on earlier versions
      content
    }
  }
}

struct correctness: ViewModifier {
  let correctIndicator: Bool?
  func body(content: Content) -> some View {
    if let correctIndicator {
      content
        .foregroundStyle(correctIndicator ? .blue : .red)
    } else {
      content
        .foregroundStyle(.clear)
    }
  }
}
