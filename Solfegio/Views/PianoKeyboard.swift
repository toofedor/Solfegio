//
//  ContentView.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI
import SwiftMIDIFile

struct PianoKeyboard: View {
  @EnvironmentObject var audioEngine: AudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @Binding var keyboard: KeyboardHelper
  @State var exercise: Exercise?

  
  let whiteHeight: Double = 250
  let whiteWidth: Double = 45
  let heightPortion: Double = 0.65
  let blackPortion: Double = 0.75
  
  
  func offsetBlack(n: Int) -> Double {
    let offset1: Double = whiteWidth / 10
    let offset6: Double = whiteWidth / 7
    switch n {
    case 1: return -offset1
    case 3: return offset1
    case 6: return -offset6
    case 10: return offset6
    default: return 0
    }
  }
  
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      let blackWidth: Double = whiteWidth * blackPortion
      let blackHeight: Double = whiteHeight * heightPortion
      let whiteCount: Int = Array(musicSettings.firstActive..<musicSettings.lastActive).count(where: { $0 !∈ [1, 3, 6, 8, 10]})
      let firstKey = musicSettings.firstActive - ((musicSettings.firstActive % 12) ∈ [1, 3, 6, 8, 10] ? 1 : 0)
      let lastKey = musicSettings.lastActive + 1 + ((musicSettings.lastActive % 12) ∈ [1, 3, 6, 8, 10] ? 1 : 0)
      
      ZStack {
        // White keys
        HStack(alignment: .top, spacing: 0) {
          ForEach(firstKey..<lastKey) { note in
            let n = note % 12
            if n !∈ [1, 3, 6, 8, 10] {
              NoteWhiteKey(width: whiteWidth, height: whiteHeight, keyboard: $keyboard, note: note, exercise: $exercise)
            }
          }
        }
        .frame(height: whiteHeight)
        
          // Black keys
        HStack(alignment: .top, spacing: 0) {
          ForEach(firstKey..<lastKey) { note in
            let n = note % 12
            if n ∈ [1, 3, 6, 8, 10] {
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: offsetBlack(n: n), keyboard: $keyboard, note: note, exercise: $exercise)
              .frame(width: 0)
            } else {
              VStack {}
                .frame(width: whiteWidth, height: whiteHeight)
            }
            
          }
        }
        .frame(height: blackHeight)
      }
      .frame(width: Double(whiteCount) * whiteWidth/2)
    }
  }
}

#Preview { 
  @Previewable @StateObject var audioEngine: AudioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  TuneExercise()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}

#Preview {
  @Previewable @StateObject var audioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings = MusicSettings()
  @Previewable @State var keyboard = KeyboardHelper()
  PianoKeyboard(keyboard: $keyboard)
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}

infix operator ∈
func ∈ <T: Equatable>(value: T, collection: [T]) -> Bool {
    collection.contains(value)
}
func ∈ <T: Comparable>(value: T, range: ClosedRange<T>) -> Bool {
  range.contains(value)
}


infix operator !∈
func !∈ <T: Equatable>(value: T, collection: [T]) -> Bool {
    !collection.contains(value)
}
func !∈ <T: Comparable>(value: T, range: ClosedRange<T>) -> Bool {
    !range.contains(value)
}
