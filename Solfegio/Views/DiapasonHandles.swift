//
//  ContentView.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI
import SwiftMIDIFile

struct DiapasonHandles: View {
  @EnvironmentObject var audioEngine: PianoAudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State var firstKey: Int = 48
  @State var lastKey: Int = 85
  @State var lower: Float = 57
  @State var upper: Float = 69
  @State var rangeActive: ClosedRange<Int> = 0...0
  @State var refresh: Bool = true
  
  var body: some View {
    VStack(spacing: 0) {
      if refresh {
        KeyboardDiapason(firstActive: $musicSettings.firstActive, lastActive: $musicSettings.lastActive)
      } else {
        KeyboardDiapason(firstActive: $musicSettings.firstActive, lastActive: $musicSettings.lastActive)
      }
      
      
      ZStack {
        if #available(iOS 26.0, *) {
          Slider(value: $lower, in: Float(firstKey)...Float(lastKey)) { _ in
            updateActive()
          }
          .saturation(0)
          .sliderThumbVisibility(.hidden)
          .offset(x: -5)
          .opacity(0.3)
          
        } else {
          Slider(value: $lower, in: Float(firstKey)...Float(lastKey)) { _ in
            updateActive()
          }
          .saturation(0)
          .offset(x: -5)
        }
        
        HStack(spacing: 0) {
          Rectangle()
            .fill(.clear)
            .frame(height: 0)
            .frame(width: 335/Double(lastKey-firstKey)*(Double(lower) - Double(firstKey)))
          Slider(value: $upper, in: Float(lower)...Float(lastKey)) { _ in
            updateActive()
          }
          .offset(x: 5)
        }
      }
      .padding(.vertical, -10)
      
      HStack {
        Text(Int(lower).toNote!.rawValue)
        Text("—")
        Text(Int(upper).toNote!.rawValue)
      }
      
    }
    .padding()
    .onAppear {
      upper = Float(musicSettings.lastActive)
      lower = Float(musicSettings.firstActive)
    }
  }
  
  func updateActive() {
    
    if lower <= upper {
      musicSettings.lastActive = Int(upper)
      musicSettings.firstActive = Int(lower)
    } else {
      musicSettings.lastActive = Int(lower)
      musicSettings.firstActive = Int(upper)
      (lower, upper) = (upper, lower)
    }
    refresh.toggle()
  }
}



#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  DiapasonHandles()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}

