//
//  File.swift
//  Solfegio
//
//  Created by Fedor Komov on 30.10.2026.
//

import SwiftUI

struct AnimValues {
  var scale: CGFloat = 10
  var offsetY: CGFloat = -1000
  var brightness: Double = 0
  var opacity: Double = 0.0
}

struct SuccessStampView: View {
  @Binding var trigger: Int
  @State private var isActive = false
  
  var body: some View {
    ZStack {
      RoundedRectangle(cornerRadius: 16)
        .fill(.clear)
        .strokeBorder(.blue , lineWidth: 3)
      VStack {
        HStack {
          Image(systemName: "star.fill")
          Image(systemName: "star.fill")
          Image(systemName: "star.fill")
        }.font(.system(size: 20))
        Text("Ура!")
      }
      .foregroundStyle(.blue)
      .font(.system(size: 40, weight: .bold, design: .default))
      .foregroundStyle(.white)
    }
    .rotationEffect(.degrees(5))
      .frame(width: 120, height: 120)
      .keyframeAnimator(
        initialValue: AnimValues(),
        trigger: trigger
      ) { content, value in
        content
          .scaleEffect(value.scale)
          .offset(y: value.offsetY)
          .brightness(value.brightness)
          .opacity(value.opacity)
      } keyframes: { _ in
        KeyframeTrack(\.scale) {
          LinearKeyframe(10, duration: 0.25)
          CubicKeyframe(1.5, duration: 0.1)
          CubicKeyframe(1, duration: 0.1)
          CubicKeyframe(1, duration: 0.25)
          SpringKeyframe(0.0, duration: 0.2, spring: .snappy)
        }
        KeyframeTrack(\.offsetY) {
          LinearKeyframe(-500, duration: 0.25)
          CubicKeyframe(-150, duration: 0.1)
          CubicKeyframe(-150, duration: 0.1)
          CubicKeyframe(-150, duration: 0.25)
          SpringKeyframe(-150, duration: 0.2, spring: .snappy)
        }
        KeyframeTrack(\.opacity) {
          LinearKeyframe(0, duration: 0.25)
          LinearKeyframe(0.7, duration: 0.1)
          LinearKeyframe(0.5, duration: 0.35)
          SpringKeyframe(0.0, duration: 0.4, spring: .snappy)
        }
      }
  }
}

#Preview {
  @Previewable @State var trigger: Int = 0
  SuccessStampView(trigger: $trigger)
    .onAppear { 
      Task {
        trigger += 1
        for _ in 0...5 {
//          Task.sleep(nanoseconds: 100)
          trigger += 1
        }
      }
    }
}
