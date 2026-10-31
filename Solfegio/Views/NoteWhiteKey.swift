//
//  NoteWhiteKey.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI

struct NoteWhiteKey: View {
  @EnvironmentObject var musicSettings: MusicSettings
  @EnvironmentObject var audioEngine: AudioEngine
  @State var width: Double
  @State var height: Double
  @Binding var keyboard: KeyboardHelper
  let note: Int
  @State var inDiapasone: Bool = false
  @State var correctIndicator: Bool?
  @Binding var exercise: Exercise?
  
  func img() -> String {
    if musicSettings.indicatorsShown {
      if let correctIndicator = keyboard.keys[note].correct {
        return correctIndicator ? "checkmark.seal.fill" : "xmark.seal.fill"
      } 
    }
    return ""
  }
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5)
        .fill(keyboard.keys[note].isOn ? .whitePressed : .white)
        .fill(.blue.opacity(inDiapasone ? 0.1 : 0))
        .strokeBorder( inDiapasone ? .black : .gray, lineWidth: inDiapasone ? 0.7 : 0.5)
        .frame(width: width, height: height)
      
      Image(systemName: img())
        .modifier(correctness(correctIndicator: keyboard.keys[note].correct))
        .offset(y: height/5)
      
      
      KeyTouchView(
        onPress: {
          keyboard.keys[note].isOn = true
          audioEngine.noteOn(note: UInt8(note), velocity: musicSettings.velocity)
          if let exercise {
            keyboard.keys[note].correct = exercise.ckeckNote(n: note)
          }
          
        },
        onRelease: {
          keyboard.keys[note].isOn = false
          audioEngine.noteOff(note: UInt8(note))
          if exercise != nil {
            keyboard.keys[note].correct = nil
          }
        }
      )
    }
    .animation(.easeInOut(duration: 0.2), value: keyboard.keys[note].correct)
  }
}

import SwiftUI
import UIKit

struct KeyTouchView: UIViewRepresentable {
    let onPress: () -> Void
    let onRelease: () -> Void

    func makeUIView(context: Context) -> TouchTrackingUIView {
        let view = TouchTrackingUIView()
        view.onPress = onPress
        view.onRelease = onRelease
        view.isMultipleTouchEnabled = true
        view.backgroundColor = .clear
        return view
    }

    func updateUIView(_ uiView: TouchTrackingUIView, context: Context) {
        uiView.onPress = onPress
        uiView.onRelease = onRelease
    }
}

final class TouchTrackingUIView: UIView {
    var onPress: (() -> Void)?
    var onRelease: (() -> Void)?
    private var isActive = false

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isActive else { return }
        isActive = true
        onPress?()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isActive else { return }
        isActive = false
        onRelease?()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard isActive else { return }
        isActive = false
        onRelease?()
    }
}

#Preview {
  @Previewable @StateObject var audioEngine: AudioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  TuneExercise()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
