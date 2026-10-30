//
//  TuneExerciseModel.swift
//  Solfegio
//
//  Created by Fedor Komov on 29.10.2026.
//

import Foundation
import SwiftUI
import Observation
import Combine

@Observable class MusicSettings: ObservableObject {
  var selInstrument: Int = 2
  var velocity: UInt8 = 64
  var velocityFloat: Double = 64
  var tempo: Tempo = Tempo()
  var tempoLog: Double = 3.584962500721
  var keyScale: KeyScale = KeyScale(tonic: Note.WithAlteration(), scale: .mollNatural)
  var tonic: KeyScale.NoteName = .A
  var scale: KeyScale.Scale = .mollHarmonic
  var btmDegree: Int = 7
  var degreeQuantity: Int = 9
  
  var firstActive: Int = 56
  var lastActive: Int = 70
  var refresh: Bool = true
  
  
}
