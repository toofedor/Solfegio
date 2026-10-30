//
//  TuneExercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import SwiftUI

struct MusicSettingsView: View {
  @EnvironmentObject var audioEngine: PianoAudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State var noteQuantity: Int = 4
  @State private var orientation = UIDevice.current.orientation
  @State var showSettings: Bool = false
  
  var body: some View {
    VStack{
      
      if orientation.isLandscape || true {
        
        HStack(spacing: 5) {
          Text("Звукоряд:")
            .font(.system(.headline, design: .default, weight: .regular))
          Text("\(musicSettings.scale.firstLowCase ? musicSettings.tonic.rawValue.lowercased() : musicSettings.tonic.rawValue)\(musicSettings.scale.name)")
            .font(.system(.headline, design: .default, weight: .medium))
        }
        .padding(.bottom, -15)
        
        HStack {
          Spacer()
          Button {
            showSettings = true
          } label: {
            Image(systemName: "gearshape.fill")
              .resizable()
              .frame(width: 30, height: 30)
          }
        }
        .padding(.horizontal, 40)
      } else {
        MusicSettingsSheet()
        .frame(width: 400)
        
      } 
      
    }
    .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
      if UIDevice.current.orientation.isValidInterfaceOrientation {
        orientation = UIDevice.current.orientation
      }
    }
    .sheet(isPresented: $showSettings, onDismiss: { 
      musicSettings.refresh.toggle()
    }, content: {
      MusicSettingsSheet()
    })
  }
}


#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  MusicSettingsView()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
