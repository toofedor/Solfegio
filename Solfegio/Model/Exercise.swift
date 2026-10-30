//
//  Exercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import Foundation

class Exercise: Identifiable {
  let id: UUID
  var tune: [Note] = []
  
  init(tune: [Note] = [], id: UUID = UUID()) {
    self.id = id
    self.tune = tune
  }
  
  func randomTune(diapason: ClosedRange<UInt8> = 59...72, noteQuantity: Int, keyScale: KeyScale) {
    let pitchSet = keyScale.buildPitchSet()
    var row: [UInt8] = []
    for i in diapason {
      if pitchSet.contains(i) {
        row.append(i)
      }
    }
    tune = []
    for _ in 0..<noteQuantity {
      tune.append(Note(pitch: row.randomElement() ?? nil))
    }
  }
}



