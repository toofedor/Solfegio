//
//  TuneExercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import SwiftUI

struct MusicSettingsSheet: View {
  @EnvironmentObject var audioEngine: PianoAudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State var noteQuantity: Int = 4
  @State var showSettings: Bool = false
  
  var body: some View {
    VStack(spacing: 15) {
      
      HStack(spacing: 5) {
        Text("Звукоряд:")
          .font(.system(.headline, design: .default, weight: .regular))
        Text("\(musicSettings.scale.firstLowCase ? musicSettings.tonic.rawValue.lowercased() : musicSettings.tonic.rawValue)\(musicSettings.scale.name)")
          .font(.system(.headline, design: .default, weight: .medium))
      }
      .padding(.bottom, -15)
      
      HStack(spacing: 5) {
        // Тоника
        Picker("", selection: $musicSettings.tonic) {
          ForEach(KeyScale.NoteName.allKeyScaleNames) { note in
            Text("\(note.nameWithSign)")
              .tag(note)
          }
        }
        //        .frame(width: 70)
        // Лад
        Picker("", selection: $musicSettings.scale) {
          ForEach(KeyScale.Scale.allCases) { note in
            Text("\(note.name)").tag(note)
          }
        }
        .offset(x: -20)
        .frame(width: 150)
        
      }
      .padding(.bottom, -20)
      
//      HStack(spacing: 5) {
//        Text("Нижняя ступень")
//        // Нижняя ступень
//        Picker("", selection: $musicSettings.btmDegree) {
//          ForEach(1..<8) { note in
//            Text("\(note.toRoman)").tag(note)
//          }
//          .lineLimit(1)
//        }
//        .frame(width: 60)
//        
//        // Звуков всего
//        Picker("", selection: $musicSettings.degreeQuantity) {
//          ForEach(1..<21) { note in
//            Text("\(note)").tag(note)
//          }
//        }
//        .frame(width: 60)
//        
//        Text("звуков")
//      }
      
      DiapasonHandles()
      
      
      Text("Темп")
        .padding(.bottom, -16)
      
      HStack(spacing: 5) {
        Picker("Длительность", selection: $musicSettings.tempo.countingDuration) {
          ForEach(Note.NoteDuration.allCases) { note in
            Text("\(note.name)").tag(note)
          }
        }
        .frame(width: 150)
        Slider(value: $musicSettings.tempoLog, in: 1...5.644, step: 0.002)
          .onChange(of: musicSettings.tempoLog) { _, _ in
            musicSettings.tempo.bpm = (10 * pow(2, musicSettings.tempoLog)).rounded()
          }
          .onTapGesture {
            DragGesture(minimumDistance: 1)
              .onEnded { _ in
                musicSettings.tempo.bpm = (10 * pow(2, musicSettings.tempoLog)).rounded()
              }
          }
          .frame(width: 140)
        Text("\(Int(musicSettings.tempo.bpm))")
          .frame(width: 40)
      }
      
      
      
      VStack(spacing: 0) {
        HStack {
          Text("Тембр")
          
          Picker("", selection: $musicSettings.selInstrument) {
            ForEach(0..<128, id: \.self) { number in
              Text("\(number.timbre)").tag(number)
            }
          }
          .pickerStyle(.menu)
          .onChange(of: musicSettings.selInstrument) { oldValue, newValue in
            audioEngine.changeProgram(progNum: UInt8(musicSettings.selInstrument))
          }
          .frame(width: 250)
        }
        
        HStack {
          Text("pp")
            .font(.system(.headline, design: .serif, weight: .bold))
            .italic()
          Slider(value: $musicSettings.velocityFloat, in: 0...127, step: 1)
            .onChange(of: musicSettings.velocityFloat) { oldValue, newValue in
              musicSettings.velocity = UInt8(musicSettings.velocityFloat)
            }
            .frame(width: 260)
          Text("ff")
            .font(.system(.headline, design: .serif, weight: .bold))
            .italic()
        }
        .padding()
      }
      
      
    }
    .frame(width: 400)
  }
}


#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  MusicSettingsSheet()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
