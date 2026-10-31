//
//  TuneExercise.swift
//  Solfegio
//
//  Created by Fedor Komov on 27.10.2026.
//

import SwiftUI

struct MusicSettingsView: View {
  @EnvironmentObject var audioEngine: AudioEngine
  @EnvironmentObject var musicSettings: MusicSettings
  @State var noteQuantity: Int = 4
  @State private var orientation = UIDevice.current.orientation
  @State var showSettings: Bool = false
  @Namespace private var settingsShowing
  
  var body: some View {
    VStack(spacing: 5) {
      
      
      HStack(spacing: 5) {
        Text("Тональность:")
          .font(.system(size: 30, weight: .thin))
        Text("\(musicSettings.scale.firstLowCase ? musicSettings.tonic.rawValue.lowercased() : musicSettings.tonic.rawValue)\(musicSettings.scale.name)")
          .font(.system(size: 35, weight: .light))
      }
      .fontWidth(.compressed)
      
      HStack {
        Toggle(isOn: $musicSettings.indicatorsShown) {
          Text("Индикаторы")
        }
        .frame(width: 170)
        
        Spacer()
          .frame(width: 150)
        
        Button {
          showSettings = true
        } label: {
          Image(systemName: "gearshape.fill")
            .resizable()
            .frame(width: 30, height: 30)
        }
        .modifier(matchedTrans(matchID: "settingsShowing", IN: settingsShowing))
      }
      .padding(.horizontal, 40)
      
      
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
        .presentationDetents([.medium, .large])
        .modifier(navigationTrans(sourceID: "settingsShowing", IN: settingsShowing))
    })
  }
}


#Preview {
  @Previewable @StateObject var audioEngine: AudioEngine = AudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  MusicSettingsView()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}
