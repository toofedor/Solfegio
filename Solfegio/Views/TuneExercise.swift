//
//  TuneExercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import SwiftUI

struct TuneExercise: View {
  @EnvironmentObject var audioEngine: PianoAudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State var exercise: Exercise = Exercise()
  @State var noteQuantity: Int = 1
  @State var showSettings: Bool = false
  var body: some View {
    VStack(spacing: 3) {
      
      MusicSettingsView()
      
      HStack(spacing: 0) {
        Button { 
          audioEngine.playExercise(exercise, tempo: musicSettings.tempo)
        } label: { 
          Image(systemName: "memories")
            .resizable()
            .frame(width: 30, height: 30)
        }
        .padding(.horizontal, 30)
        
        Button { 
          exercise.randomTune(diapason: UInt8(musicSettings.firstActive)...UInt8(musicSettings.lastActive), noteQuantity: noteQuantity, keyScale: KeyScale(tonic: musicSettings.tonic, scale: musicSettings.scale))
          
          audioEngine.playExercise(exercise, tempo: musicSettings.tempo)
        } label: { 
          Image(systemName: "forward.fill")
            .resizable()
            .frame(width: 35, height: 25)
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
      
      if musicSettings.refresh {
        PianoKeyboard()
      } else {
        PianoKeyboard()
      }
      
    }
    .onAppear {
      if exercise.tune.isEmpty {
        exercise.randomTune(diapason: 56...70, noteQuantity: noteQuantity, keyScale: KeyScale(tonic: Note.WithAlteration(.A), scale: .mollHarmonic))
      }
    }
  }
}

#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  MainScreen()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}

#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  TuneExercise()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
