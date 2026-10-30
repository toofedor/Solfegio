//
//  MainScreen.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//

import SwiftUI

struct MainScreen: View {
  var body: some View {
      
      TuneExercise()
    
  }
}

#Preview {
  @Previewable @StateObject var audioEngine: PianoAudioEngine = PianoAudioEngine()
  @Previewable @StateObject var musicSettings: MusicSettings = MusicSettings()
  MainScreen()
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
}



