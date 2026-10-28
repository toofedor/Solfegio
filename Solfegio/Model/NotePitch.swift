////
////  NotePitch.swift
////  Solfegio
////
////  Created by Fedor Komov on 28.10.2026.
////
//
//import Foundation
//
//class NotePitch {
//  var noteName: noteShortName
//  var alteration: UInt8
//  
//  init(_ noteName: noteShortName, alt alteration: UInt8 = 0) {
//    self.noteName = noteName
//    self.alteration = alteration
//  }
//  
//  enum noteShortName {
//    case C
//    case D
//    case E
//    case F
//    case G
//    case A
//    case B
//    
//    var midi: UInt8 {
//      switch self {
//      case .C: return 0
//      case .D: return 2
//      case .E: return 4
//      case .F: return 5
//      case .G: return 7
//      case .A: return 9
//      case .B: return 11
//      }
//    }
//  
//  }
//  
//}
