//
//  NoteWhiteKey.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI

struct NoteWhiteKey: View {
  @State var width: Double
  @State var height: Double
  @Binding var keyboard: KeyboardHelper
  @State var audioEngine: PianoAudioEngine
  let note: Int
  @Binding var velocity: UInt8
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 5)
        .fill(keyboard.keys[note].isOn ? .whitePressed : .white)
        .strokeBorder(.gray, lineWidth: 0.5)
        .frame(width: width, height: height)
      
      KeyTouchView(
        onPress: {
          keyboard.keys[note].isOn = true
          audioEngine.noteOn(note: UInt8(note), velocity: velocity)
        },
        onRelease: {
          keyboard.keys[note].isOn = false
          audioEngine.noteOff(note: UInt8(note))
        }
      )
    }
  }
}

#Preview {
//  NoteWhiteKey(width: 50, height: 200, keyboard: , audioEngine: PianoAudioEngine(), note: 2)
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
