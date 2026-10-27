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

class PianoAudioEngine: ObservableObject {
  
  private let engine = AVAudioEngine()
  private let sampler = AVAudioUnitSampler()
  
  init() {
    
    engine.attach(sampler)
    engine.connect(sampler, to: engine.mainMixerNode, format: nil)
    
    
    if let bankURL = Bundle.main.url(forResource: "GeneralUser GS", withExtension: "sf2") {
      do {
        try sampler.loadSoundBankInstrument(
          at: bankURL,
          program: 2, // 0 = Acoustic Grand Piano
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
          program: progNum, // 0 = Acoustic Grand Piano
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
  
  func noteOn(note: UInt8, velocity: UInt8 = 64) {
    sampler.startNote(note, withVelocity: velocity, onChannel: 0)
  }
  
  func noteOff(note: UInt8) {
    sampler.stopNote(note, onChannel: 0)
  }
}
