//
//  TuneExercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import SwiftUI

struct TuneExercise: View {
  @State var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @State var selIns: Int = 2
  @State var exercise: Exercise = Exercise()
  @State var tempo: Tempo = Tempo()
  @Binding var velocity: UInt8
  @State var tempoLog: Double = 3.584962500721
    var body: some View {
      VStack{
        HStack(spacing: 50) {
          Button { 
            audioEngine.playExercise(exercise, tempo: tempo)
          } label: { 
            Image(systemName: "play")
          }
          
          Button { 
            exercise.randomTune(diapason: 56...70, noteQuantity: 4, keyScale: KeyScale(tonic: Note.NotePitch(.A), scale: .mollHarmonic))
          } label: { 
            Image(systemName: "arrow.clockwise")
          }
          
          
        }
        
        HStack(spacing: 5) {
          Picker("Темп", selection: $tempo.countingDuration) {
            ForEach(Note.NoteDuration.allCases) { note in
              Text("\(note.name)").tag(note)
            }
          }
          .frame(width: 100)
          Text("Темп")
          Slider(value: $tempoLog, in: 1...5.644, step: 0.002)
            .onChange(of: tempoLog) { _, _ in
              tempo.bpm = (10 * pow(2, tempoLog)).rounded()
            }
            .frame(width: 140)
          Text("\(Int(tempo.bpm))")
            .frame(width: 40)
        }
        .padding()
        
        
        
        PianoKeyboard(audioEngine: $audioEngine, velocity: $velocity, firstKey: 56, lastKey: 70)
      }
      .onAppear {
        if exercise.tune.isEmpty {
          exercise.randomTune(diapason: 56...70, noteQuantity: 4, keyScale: KeyScale(tonic: Note.NotePitch(.A), scale: .mollHarmonic))
        }
      }
    }
}

//#Preview {
//    TuneExercise()
//}
