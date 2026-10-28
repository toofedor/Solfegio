//
//  Note.swift
//  Solfegio
//
//  Created by Fedor Komov on 28.10.2026.
//

import Foundation

class Note {
  var pitch: UInt8
  var duration: NoteDuration
  var velocity: UInt8
  
  init(pitch: UInt8? = 60, duration: NoteDuration = .n4, velocity: UInt8 = 80) {
    self.pitch = pitch ?? 0
    self.duration = duration
    self.velocity = velocity
  }
  
  enum NoteDuration: Double, CaseIterable, Identifiable {  
    case n1  = 1.0
    case n2  = 0.5
    case n4  = 0.25
    case n8  = 0.125
    case n16 = 0.0625
    case n32 = 0.03125
    case n64 = 0.015625
    
    case d1  = 1.5
    case d2  = 0.75
    case d4  = 0.375
    case d8  = 0.1875
    case d16 = 0.09375
    case d32 = 0.046875
    case d64 = 0.0234375
    
    case tr1  = 1.3333333333333333333333333333333333333333333333
    case tr2  = 0.6666666666666666666666666666666666666666666667
    case tr4  = 0.3333333333333333333333333333333333333333333333
    case tr8  = 0.1666666666666666666666666666666666666666666667
    case tr16 = 0.0833333333333333333333333333333333333333333333
    case tr32 = 0.0416666666666666666666666666666666666666666667
    case tr64 = 0.0208333333333333333333333333333333333333333333
    
    var id: String { self.name }
    
    var name: String {
      switch self {
      case .n1  : "Целая"
      case .n2  : "Половинная"
      case .n4  : "Четверная"
      case .n8  : "8-я"
      case .n16 : "16-я"
      case .n32 : "32-я"
      case .n64 : "64-я"
      
      case .d1  : "Целая с точкой"
      case .d2  : "Половинная с точкой"
      case .d4  : "Четверная с точкой"
      case .d8  : "8-я с точкой"
      case .d16 : "16-я с точкой"
      case .d32 : "32-я с точкой"
      case .d64 : "64-я с точкой"
      
      case .tr1 : "Целая триоль"
      case .tr2 : "Половинная триоль"
      case .tr4 : "Четверная триоль"
      case .tr8 : "8-я триоль"
      case .tr16: "16-я триоль"
      case .tr32: "32-я триоль"
      case .tr64: "64-я триоль"
      }
    }
    
  }
  
  class NotePitch {
    var noteName: noteShortName
    var alteration: UInt8
    
    init(_ noteName: noteShortName, alt alteration: UInt8 = 0) {
      self.noteName = noteName
      self.alteration = alteration
    }
    
    enum noteShortName {
      case C
      case D
      case E
      case F
      case G
      case A
      case B
      
      var midi: UInt8 {
        switch self {
        case .C: return 0
        case .D: return 2
        case .E: return 4
        case .F: return 5
        case .G: return 7
        case .A: return 9
        case .B: return 11
        }
      }
    
    }
    
  }
}
