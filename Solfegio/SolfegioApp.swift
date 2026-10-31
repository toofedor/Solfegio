//
//  SolfegioApp.swift
//  Solfegio
//
//  Created by Fedor Komov on 26.10.2026.
//  
//  Includes SwiftMIDI File, MIT
//

import SwiftUI

@main
struct SolfegioApp: App {
  @StateObject var audioEngine: AudioEngine = AudioEngine()
  @StateObject var musicSettings: MusicSettings = MusicSettings()
  var body: some Scene {
    WindowGroup {
      MainScreen()
    }
    .environmentObject(audioEngine)
    .environmentObject(musicSettings)
  }
}
