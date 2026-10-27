//
//  ContentView.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI
import SwiftMIDIFile

struct PianoKeyboard: View {
  @Binding var audioEngine: PianoAudioEngine
  @State var keyboard: KeyboardHelper = KeyboardHelper()
  let firstKey: Int
  let lastKey: Int
  @Binding var velocity: UInt8
  
  let whiteHeight: Double = 250
  let whiteWidth: Double = 45
  let heightPortion: Double = 2/3
  let blackPortion: Double = 0.75
  
  init(audioEngine: Binding<PianoAudioEngine>, velocity: Binding<UInt8>, firstKey: Int = 48, lastKey: Int = 72) {
    self._audioEngine = audioEngine
    self._velocity = velocity
    self.firstKey = firstKey - ((firstKey % 12) ∈ [1, 3, 6, 8, 10] ? 1 : 0)
    self.lastKey = lastKey + 1 + ((lastKey % 12) ∈ [1, 3, 6, 8, 10] ? 1 : 0)
    //
  }
  
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      let offset1: Double = whiteWidth / 10
      let offset6: Double = whiteWidth / 7
      let blackWidth: Double = whiteWidth * blackPortion
      let blackHeight: Double = whiteHeight * heightPortion
      
      ZStack {
        // White keys
        HStack(alignment: .top, spacing: 0) {
          ForEach(firstKey..<lastKey) { note in
            let n = note % 12
            if n !∈ [1, 3, 6, 8, 10] {
              NoteWhiteKey(width: whiteWidth, height: whiteHeight, keyboard: $keyboard, audioEngine: audioEngine, note: note, velocity: $velocity)
            }
          }
        }
        .frame(height: whiteHeight)
        
          // Black keys
        HStack(alignment: .top, spacing: 0) {
          ForEach(firstKey..<lastKey) { note in
            let n = note % 12
            switch n {
            case 0, 2, 4:
              VStack {}
                .frame(width: whiteWidth, height: whiteHeight)
            case 5, 7, 9, 11:
              VStack {}
                .frame(width: whiteWidth, height: whiteHeight)
            case 1: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: -offset1, keyboard: $keyboard, audioEngine: audioEngine, note: note, velocity: $velocity)
            }
            .frame(width: 0)
            case 3: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: offset1, keyboard: $keyboard, audioEngine: audioEngine, note: note, velocity: $velocity)
            }
            .frame(width: 0)
            case 6: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: -offset6, keyboard: $keyboard, audioEngine: audioEngine, note: note, velocity: $velocity)
            }
            .frame(width: 0)
            case 8: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: 0, keyboard: $keyboard, audioEngine: audioEngine, note: note, velocity: $velocity)
            }
            .frame(width: 0)
            case 10: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: offset6, keyboard: $keyboard, audioEngine: audioEngine, note: note, velocity: $velocity)
            }
            .frame(width: 0)
            default: HStack{}
            }
          }
        }
        .frame(height: blackHeight)
        
      }
      
    }
    .padding()
  }
}

#Preview { 
  MainScreen()
}

#Preview {
  @Previewable @State var audioEngine = PianoAudioEngine()
  PianoKeyboard(audioEngine: $audioEngine, velocity: .constant(80))
}

infix operator ∈
func ∈ <T: Equatable>(value: T, collection: [T]) -> Bool {
    collection.contains(value)
}

infix operator !∈
func !∈ <T: Equatable>(value: T, collection: [T]) -> Bool {
    !collection.contains(value)
}
