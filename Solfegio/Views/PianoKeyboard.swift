//
//  ContentView.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI
import SwiftMIDIFile

struct PianoKeyboard: View {
  @EnvironmentObject var audioEngine: PianoAudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State var keyboard: KeyboardHelper = KeyboardHelper()

  
  let whiteHeight: Double = 250
  let whiteWidth: Double = 45
  let heightPortion: Double = 0.65
  let blackPortion: Double = 0.75
  
  
  
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      let offset1: Double = whiteWidth / 10
      let offset6: Double = whiteWidth / 7
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
              NoteWhiteKey(width: whiteWidth, height: whiteHeight, keyboard: $keyboard, note: note)
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
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: -offset1, keyboard: $keyboard, note: note)
            }
            .frame(width: 0)
            case 3: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: offset1, keyboard: $keyboard, note: note)
            }
            .frame(width: 0)
            case 6: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: -offset6, keyboard: $keyboard, note: note)
            }
            .frame(width: 0)
            case 8: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: 0, keyboard: $keyboard, note: note)
            }
            .frame(width: 0)
            case 10: HStack{
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: offset6, keyboard: $keyboard, note: note)
            }
            .frame(width: 0)
            default: HStack{}
            }
          }
        }
        .frame(height: blackHeight)
      }
      .frame(width: Double(whiteCount) * whiteWidth/2)
    }
    .padding()
  }
}

#Preview { 
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  TuneExercise()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}

#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  PianoKeyboard()
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
