//
//  Exercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import Foundation
import SwiftUI
import Observation
import Combine

@Observable class Exercise: ObservableObject, Identifiable {
  let id: UUID
  var tune: [Note] = []
  var tuneNoteIndex: Int = 0
  var win: Int = 0
  var points: Int = 0
  var notGuessedYet: Bool = true
  
  init(tune: [Note] = [], id: UUID = UUID()) {
    self.id = id
    self.tune = tune
  }
  
  func ckeckNote(n: Int) -> Bool {
    guard tune.indices.contains(tuneNoteIndex) else { return false }
    let correct = tune[tuneNoteIndex].pitch == n
    if correct {
      tuneNoteIndex += 1
      
      if tune.count <= tuneNoteIndex {
        win += 1
        tuneNoteIndex = 0
        if notGuessedYet {
          points += 1
          notGuessedYet = false
        }
      }
      
    } else {
      tuneNoteIndex = 0
      if notGuessedYet {
        points -= 1
        print(notGuessedYet)
      }
    }
    return correct
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
    notGuessedYet = true
  }
  
}



