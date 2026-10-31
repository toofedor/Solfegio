//
//  Tune.swift
//  Solfegio
//
//  Created by Fedor Komov on 31.10.2026.
//

import Foundation

class Melody {
  let id: UUID
  var tune: [Note]?
  var isPlaying: Bool = false
  var tempo: Tempo = Tempo(120)
  
  init(id: UUID, melody: [Note]? = nil) {
    self.id = id
    self.tune = melody
  }
  
  func play(with player: AudioEngine) {
    if !isPlaying {
      let channal: UInt8 = 15
      Task {
        isPlaying = true
        if let tune = self.tune {
          for note in tune {
            player.noteOn(note: note.pitch, velocity: note.velocity, onChannel: channal)
            try await Task.sleep(nanoseconds: UInt64(1000000000.0 * tempo.wholeInSeconds * note.duration.rawValue))
            player.noteOff(note: note.pitch, onChannel: channal)
          } // |for note|
        }
        isPlaying = false
        
      } // |Task|
    }
  } // |func play|
  
  
}
