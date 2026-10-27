//
//  KeyboardHelper.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import Foundation
import SwiftUI
import Observation
import Combine

@Observable class KeyboardHelper: ObservableObject {
  var keys: [Key]
  var audioEngine = PianoAudioEngine()
  
  init() {
    var keys: [Key] = []
    for i in 0..<128 {
      keys.append(Key(number: i))
    }
    self.keys = keys
  }
  
  func changeInstrument(progNum: UInt8 = 2) {
    audioEngine.changeProgram(progNum: progNum)
  }
  
}

@Observable class Key: ObservableObject {
  let number: Int
  var isOn: Bool = false
  
  init(number: Int) {
    self.number = number
  }
}
