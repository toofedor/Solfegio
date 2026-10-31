//
//  Temp.swift
//  Solfegio
//
//  Created by Fedor Komov on 28.10.2026.
//

import Foundation

class Tempo {
  var bpm: Double
  var countingDuration: Note.NoteDuration
  var wholeInSeconds: Double {
    return 60.0 / (bpm * countingDuration.rawValue)
  }
  
  init(_ bpm: Double = 120, countingDuration: Note.NoteDuration = .n4) {
    self.bpm = bpm
    self.countingDuration = countingDuration
  }
}
