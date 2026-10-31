//
//  TuneExercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import SwiftUI

struct TuneExercise: View {
  @EnvironmentObject var audioEngine: AudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State private var orientation = UIDevice.current.orientation
  @State var keyboard = KeyboardHelper()
  @State var exercise: Exercise = Exercise()
  @State var noteQuantity: Int = 1
  @State var showSettings: Bool = false
  @State var tuneNoteIndex: Int = 0
  @State var stampOffset: Double = -150
  var body: some View {
    ZStack {
      VStack {
        Text("\(musicSettings.scale.firstLowCase ? musicSettings.tonic.rawValue.lowercased() : musicSettings.tonic.rawValue)\(musicSettings.scale.name)")
          .foregroundStyle(.blackWhire)
          .ignoresSafeArea()
          .fontWidth(.compressed)
          .font(.system(size: 250, weight: .regular))
//          .font(.system(size: 150, weight: .black, design: .serif))
          .rotationEffect(.degrees(-70))
          .lineLimit(1)
          .frame(minWidth: 1500)
      }
      
      VStack(spacing: 0) {
        
        MusicSettingsView()
          .padding(.bottom, 10)
        
        if musicSettings.refresh {
          PianoKeyboard(keyboard: $keyboard, exercise: exercise)
        } else {
          PianoKeyboard(keyboard: $keyboard, exercise: exercise)
        }
        
        
        HStack(spacing: 0) {
          Text("Быллы:").padding()
          Text("\(exercise.points)")
            .fontWidth(.compressed)
            .font(.system(size: 50, weight: .thin))
            .frame(width: 50)
          
          Button { 
            keyboard.pressedKey = nil
            exercise.tuneNoteIndex = 0
            audioEngine.playExercise(exercise, tempo: musicSettings.tempo)
          } label: { 
            Image(systemName: "memories")
              .scaleEffect(2)
          }
          .padding(.horizontal, 30)
          
          Button { 
            exercise.tuneNoteIndex = 0
            keyboard.pressedKey = nil
            exercise.randomTune(diapason: UInt8(musicSettings.firstActive)...UInt8(musicSettings.lastActive), noteQuantity: noteQuantity, keyScale: KeyScale(tonic: musicSettings.tonic, scale: musicSettings.scale))
            
            audioEngine.playExercise(exercise, tempo: musicSettings.tempo)
          } label: { 
            Image(systemName: "forward.fill")
              .scaleEffect(1.6)
          }
          .padding(.horizontal, 20)
          
          Picker("Всего нот", selection: $noteQuantity) {
            ForEach(1..<21) { n in
              Text("\(n)")
                .tag(n)
            }
          }
          Text("нот\(noteQuantity ∈ [2, 3, 4] ? "ы" : (noteQuantity == 1 ? "а" : ""))")
            .padding(.leading, -10)
        }
        
        
      }
      if musicSettings.indicatorsShown {
        SuccessStampView(trigger: $exercise.win)
          .offset(y: stampOffset)
      }
    }
    .onAppear {
      if exercise.tune.isEmpty {
        exercise.randomTune(diapason: 56...70, noteQuantity: noteQuantity, keyScale: KeyScale(tonic: Note.WithAlteration(.A), scale: .mollHarmonic))
      }
      if orientation.isLandscape {
        stampOffset = 150
      } else {
        stampOffset = -150
      }
    }
    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
      if UIDevice.current.orientation.isValidInterfaceOrientation {
        orientation = UIDevice.current.orientation
        if orientation.isLandscape {
          stampOffset = 150
        } else {
          stampOffset = -150
        }
      }
    }
  }
}

#Preview {
  @Previewable @StateObject var audioEngine: AudioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  MainScreen()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}

#Preview {
  @Previewable @StateObject var audioEngine: AudioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  TuneExercise()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
