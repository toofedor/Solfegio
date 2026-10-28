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

















//enum NoteDuration_: Double {
//  
//  case whole        = 1.0
//  case half         = 0.5
//  case quarter      = 0.25
//  case eighth       = 0.125
//  case sixteenth    = 0.0625
//  case thirtySecond = 0.03125
//  case sixtyFourth  = 0.015625
//  
//  case whole_dot        = 1.5
//  case half_dot         = 0.75
//  case quarter_dot      = 0.375
//  case eighth_dot       = 0.1875
//  case sixteenth_dot    = 0.09375
//  case thirtySecond_dot = 0.046875
//  case sixtyFourth_dot  = 0.0234375
//  
//  case whole_3        = 1.3333333333333333333333333333333333333333333333
//  case half_3         = 0.6666666666666666666666666666666666666666666667
//  case quarter_3      = 0.3333333333333333333333333333333333333333333333
//  case eighth_3       = 0.1666666666666666666666666666666666666666666667
//  case sixteenth_3    = 0.0833333333333333333333333333333333333333333333
//  case thirtySecond_3 = 0.0416666666666666666666666666666666666666666667
//  case sixtyFourth_3  = 0.0208333333333333333333333333333333333333333333
//  
//  
//}
