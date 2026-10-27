//
//  NoteWhiteKey.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI

struct NoteBlackKey: View {
  @State var width: Double
  @State var height: Double
  @State var offset: Double
  @Binding var keyboard: KeyboardHelper
  @State var audioEngine: PianoAudioEngine
  let note: Int
  @Binding var velocity: UInt8
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5)
        .fill(keyboard.keys[note].isOn ? .blackPressed : .black)
        .strokeBorder(.gray, lineWidth: 0.5)
        .frame(width: width, height: height)
        .offset(x: offset)
      
      KeyTouchView(
        onPress: {
          keyboard.keys[note].isOn = true
          audioEngine.noteOn(note: UInt8(note), velocity: velocity)
        },
        onRelease: {
          keyboard.keys[note].isOn = false
          audioEngine.noteOff(note: UInt8(note))
        }
      )
    }
  }
}

#Preview {
//  NoteBlackKey(width: 50, height: 200, offset: 5, note: 30)
}
