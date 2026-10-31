//
//  ContentView.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI
import SwiftMIDIFile

struct KeyboardDiapason: View {
  @EnvironmentObject var audioEngine: AudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State var keyboard: KeyboardHelper = KeyboardHelper()
  @State var exercise: Exercise? = nil
  let firstKey: Int = 48
  let lastKey: Int = 85
  @Binding var firstActive: Int
  @Binding var lastActive: Int
  
  let whiteHeight: Double = 70
  let whiteWidth: Double = 18
  let heightPortion: Double = 0.6
  let blackPortion: Double = 0.75
  
  func inDiapason(_ n: Int) -> Bool {
    return n ∈ (firstActive...lastActive)
  }
  func scaleInRange(_ n: Int, _ factor: Double = 1.1) -> Double {
    return inDiapason(n) ? factor : 1.0
  }
  func opacityInRange(_ n: Int, _ factor: Double = 0.5) -> Double {
    return inDiapason(n) ? factor : 1.0
  }
  
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
    VStack {
      let offset1: Double = whiteWidth / 10
      let offset6: Double = whiteWidth / 7
      let blackWidth: Double = whiteWidth * blackPortion
      let blackHeight: Double = whiteHeight * heightPortion
      let whiteCount: Int = Array(firstKey..<lastKey).count(where: { $0 !∈ [1, 3, 6, 8, 10]})
      
      
      ZStack {
        // White keys
        HStack(spacing: 0) {
          ForEach(["Малая", "1я", "2я"], id: \.self) { oct in
            
            ZStack {
              Text("\(oct) октава")
                .font(.system(.caption2, design: .default, weight: .light))
                .offset(y: 7 - whiteHeight / 2)
              RoundedRectangle(cornerRadius: 5)
                .fill(.clear)
                .strokeBorder(.gray.secondary, lineWidth: 0.5)
                .frame(width: whiteWidth * 7, height: whiteHeight)
            }
          }
        }
        .offset(x: -whiteWidth / 2, y: -15)
        
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
              NoteBlackKey(width: blackWidth, height: blackHeight, offset: offsetBlack(n: n), keyboard: $keyboard, note: note, inDiapasone: inDiapason(note), exercise: $exercise)
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
    .padding()
  }
}



#Preview {
  @Previewable @StateObject var audioEngine: AudioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  KeyboardDiapason(firstActive: .constant(57), lastActive: .constant(69))
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}

