//
//  NoteWhiteKey.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI

struct NoteBlackKey: View {
  @EnvironmentObject var musicSettings: MusicSettings
  @EnvironmentObject var audioEngine: PianoAudioEngine
  @State var width: Double
  @State var height: Double
  @State var offset: Double
  @Binding var keyboard: KeyboardHelper
  let note: Int
  @State var inDiapasone: Bool = false
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5)
        .fill(.white)
        .fill(.blue)
        .fill(inDiapasone ? .black.opacity(keyboard.keys[note].isOn ? 0.45 : 0.55) : (keyboard.keys[note].isOn ? .blackPressed : .black))
        .strokeBorder(.gray, lineWidth: inDiapasone ? 1 : 0.5)
        .frame(width: width, height: height)
        
      
      KeyTouchView(
        onPress: {
          keyboard.keys[note].isOn = true
          audioEngine.noteOn(note: UInt8(note), velocity: musicSettings.velocity)
        },
        onRelease: {
          keyboard.keys[note].isOn = false
          audioEngine.noteOff(note: UInt8(note))
        }
      )
      .padding(.horizontal, -10)
    }
    .offset(x: offset)
  }
}

#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  TuneExercise()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
