//
//  MainScreen.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI

struct MainScreen: View {
  @State var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @State var selIns: Int = 2
  @State var velocity: UInt8 = 64
  @State var velocityFloat: Double = 64
  var body: some View {
    VStack{
      Picker("Тембр", selection: $selIns) {
        ForEach(0..<128, id: \.self) { number in
          Text("\(number.timbre)").tag(number)
        }
      }
      .pickerStyle(.menu)
      .onChange(of: selIns) { oldValue, newValue in
        audioEngine.changeProgram(progNum: UInt8(selIns))
      }
      
      HStack {
        Text("Velocity:")
        Slider(value: $velocityFloat, in: 0...127, step: 1)
          .onChange(of: velocityFloat) { oldValue, newValue in
            velocity = UInt8(velocityFloat)
            print(velocity)
          }
          .frame(width: 260)
      }
        .padding()
      
      PianoKeyboard(audioEngine: $audioEngine, velocity: $velocity, firstKey: 48, lastKey: 88)
    }
  }
}

#Preview {
  MainScreen()
}
