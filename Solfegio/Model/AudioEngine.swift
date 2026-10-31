//
//  PianoEngine.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import AVFoundation
import SwiftUI
import Observation
import Combine

class AudioEngine: ObservableObject {
  
  private let engine = AVAudioEngine()
  private let sampler = AVAudioUnitSampler()
  var freechannals: [Bool] = [true, true, true, true,  true, true, true, true, 
                              true, true, true, true,  true, true, true, true]
  
  func playExercise(_ exercise: Exercise, tempo: Tempo) {
    Task {
      let slot: Int? = freechannals.firstIndex(where: { $0 }) ?? nil
      if let slot {
        freechannals[slot] = false
        let channal: UInt8 = UInt8(slot)
        for note in exercise.tune {
          noteOn(note: note.pitch, velocity: note.velocity, onChannel: channal)
          try await Task.sleep(nanoseconds: UInt64(1000000000.0 * tempo.wholeInSeconds * note.duration.rawValue))
          noteOff(note: note.pitch, onChannel: channal)
        }
        freechannals[slot] = true
      }
    }
  }
  
  
  
  init() {
    
    engine.attach(sampler)
    engine.connect(sampler, to: engine.mainMixerNode, format: nil)
    
    
    if let bankURL = Bundle.main.url(forResource: "GeneralUser GS", withExtension: "sf2") {
      do {
        try sampler.loadSoundBankInstrument(
          at: bankURL,
          program: 2, 
          bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
          bankLSB: UInt8(kAUSampler_DefaultBankLSB)
        )
      } catch {
        print("Ошибка загрузки банка: \(error)")
      }
    }
    do {
      try engine.start()
    } catch {
      print("Ошибка запуска движка: \(error)")
    }
  }
  
  func changeProgram(progNum: UInt8 = 2) {
    engine.stop()
    
    if let bankURL = Bundle.main.url(forResource: "GeneralUser GS", withExtension: "sf2") {
      do {
        try sampler.loadSoundBankInstrument(
          at: bankURL,
          program: progNum, 
          bankMSB: UInt8(kAUSampler_DefaultMelodicBankMSB),
          bankLSB: UInt8(kAUSampler_DefaultBankLSB)
        )
      } catch {
        print("Ошибка загрузки банка: \(error)")
      }
    }
    
    do {
      try engine.start()
    } catch {
      print("Ошибка запуска движка: \(error)")
    }
    
  }
  
  func noteOn(note: UInt8, velocity: UInt8 = 64, onChannel: UInt8 = 0) {
    sampler.startNote(note, withVelocity: velocity, onChannel: onChannel)
  }
  
  func noteOff(note: UInt8, onChannel: UInt8 = 0) {
    sampler.stopNote(note, onChannel: onChannel)
  }
}
