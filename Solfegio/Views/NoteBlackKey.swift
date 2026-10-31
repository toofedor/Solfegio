//
//  NoteWhiteKey.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI

struct NoteBlackKey: View {
  @EnvironmentObject var musicSettings: MusicSettings
  @EnvironmentObject var audioEngine: AudioEngine
  @State var width: Double
  @State var height: Double
  @State var offset: Double
  @Binding var keyboard: KeyboardHelper
  let note: Int
  @State var inDiapasone: Bool = false
  @State var correctIndicator: Bool?
  @Binding var exercise: Exercise?
  
  func img() -> String {
    if musicSettings.indicatorsShown {
      if let correctIndicator = keyboard.keys[note].correct {
        return correctIndicator ? "checkmark.seal.fill" : "xmark.seal.fill"
      } 
    }
    return ""
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5)
        .fill(.white)
        .fill(.blue)
        .fill(inDiapasone ? .black.opacity(keyboard.keys[note].isOn ? 0.45 : 0.55) : (keyboard.keys[note].isOn ? .blackPressed : .black))
        .strokeBorder(.gray, lineWidth: inDiapasone ? 1 : 0.5)
        .frame(width: width, height: height)
      
      Image(systemName: img())
        .modifier(correctness(correctIndicator: keyboard.keys[note].correct))
        .offset(y: -height / 3)
      
      
      KeyTouchView(
        onPress: {
          keyboard.keys[note].isOn = true
          audioEngine.noteOn(note: UInt8(note), velocity: musicSettings.velocity)
          if let exercise {
            keyboard.keys[note].correct = exercise.ckeckNote(n: note)
          }
          
        },
        onRelease: {
          keyboard.keys[note].isOn = false
          audioEngine.noteOff(note: UInt8(note))
          if exercise != nil {
            keyboard.keys[note].correct = nil
          }
        }
      )
      .padding(.horizontal, -10)
    }
    .offset(x: offset)
  }
}

#Preview {
  @Previewable @StateObject var audioEngine: AudioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  TuneExercise()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
