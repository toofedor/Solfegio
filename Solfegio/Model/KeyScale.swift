//
//  KeyScale.swift
//  Solfegio
//
//  Created by Fedor Komov on 28.10.2026.
//

import Foundation

class KeyScale {
  var tonic: Note.NotePitch
  var scale: Scale
  
  init(tonic: Note.NotePitch, scale: Scale) {
    self.tonic = tonic
    self.scale = scale
  }
  
  func buildPitchSet() -> [UInt8] {
    let root: UInt8 = tonic.noteName.midi + tonic.alteration
    var pitchSet: [UInt8] = [root]
    var curNote: UInt8 = root
    while curNote <= 127 {
      for i in scale.buildMidi {
//        guard let i else { continue }
        if curNote + i <= 127 {
          pitchSet.append(curNote + i)
        } else { 
          break 
        }
      }
      curNote += 12
    }
    return pitchSet
  }
  
  
  enum noteName {
    case Ases
    case As
    case A
    case Ais
    case Aisis
    case Bes
    case B
    case H
    case His
    case Ces
    case C
    case Cis
    case Cisis
    case Deses
    case Des
    case D
    case Dis
    case Disis
    case Eses
    case Es
    case E
    case F
    case Fis
    case Fisis
    case Geses
    case Ges
    case G
    case Gis
    case Gisis
    
    var midi: UInt8 {
      switch self {
      case .Ases: return 31
      case .As: return 32
      case .A: return 33
      case .Ais: return 34
      case .Aisis: return 35
      case .Bes: return 33
      case .B: return 34
      case .H: return 35
      case .His: return 36
      case .Ces: return 23
      case .C: return 24
      case .Cis: return 25
      case .Cisis: return 26
      case .Deses: return 24
      case .Des: return 25
      case .D: return 26
      case .Dis: return 27
      case .Disis: return 28
      case .Eses: return 26
      case .Es: return 27
      case .E: return 28
      case .F: return 29
      case .Fis: return 30
      case .Fisis: return 31
      case .Geses: return 29
      case .Ges: return 30
      case .G: return 31
      case .Gis: return 32
      case .Gisis: return 33
      }
    }
    
    
    var mainNote: noteName {
      switch self {
      case .Ases: return .A
      case .As: return .A
      case .A: return .A
      case .Ais: return .A
      case .Aisis: return .A
      case .Bes: return .H
      case .B: return .H
      case .H: return .H
      case .His: return .H
      case .Ces: return .C
      case .C: return .C
      case .Cis: return .C
      case .Cisis: return .C
      case .Deses: return .D
      case .Des: return .D
      case .D: return .D
      case .Dis: return .D
      case .Disis: return .D
      case .Es: return .E
      case .Eses: return .E
      case .E: return .E
      case .F: return .F
      case .Fis: return .F
      case .Fisis: return .F
      case .Geses: return .G
      case .Ges: return .G
      case .G: return .G
      case .Gis: return .G
      case .Gisis: return .G
      }
    }
    
    var alteration: Int {
      switch self {
      case .Ases: return -2
      case .As: return -1
      case .A: return 0
      case .Ais: return 1
      case .Aisis: return 2
      case .Bes: return -2
      case .B: return -1
      case .H: return 0
      case .His: return 1
      case .Ces: return -1
      case .C: return 0
      case .Cis: return 1
      case .Cisis: return 2
      case .Deses: return -2
      case .Des: return -1
      case .D: return 0
      case .Dis: return 1
      case .Disis: return 2
      case .Es: return -1
      case .Eses: return -2
      case .E: return 0
      case .F: return 0
      case .Fis: return 1
      case .Fisis: return 2
      case .Geses: return -2
      case .Ges: return -1
      case .G: return 0
      case .Gis: return 1
      case .Gisis: return 2
      }
    }
  }
  
  
  
  enum Scale {
    case durNatural
    case mollNatural
    case durHarmonic
    case mollHarmonic
    case durMelodic
    case mollMelodic
    case durDoubleHarmonic
    case mollDoubleHarmonic
    case durPentatonic
    case mollPentatonic
    case bluesScale
    case chromatic
    case wholetone
    case rimKor
    
    var buildMidi: [UInt8] {
      switch self {
      case .durNatural: return [0, 2, 4, 5, 7, 9, 11]
      case .mollNatural: return [0, 2, 3, 5, 7, 8, 10]
      case .durHarmonic: return [0, 2, 4, 5, 7, 8, 11]
      case .mollHarmonic: return [0, 2, 3, 5, 7, 8, 11]
      case .durMelodic: return [0, 2, 4, 5, 7, 8, 10]
      case .mollMelodic: return [0, 2, 3, 5, 7, 9, 11]
      case .durDoubleHarmonic: return [0, 1, 4, 5, 7, 8, 11]
      case .mollDoubleHarmonic: return [0, 2, 3, 6, 7, 8, 11]
      case .durPentatonic: return [0, 2, 4, 7, 9]
      case .mollPentatonic: return [0, 3, 5, 7, 11]
      case .bluesScale: return [0, 4, 5, 7, 11]
      case .chromatic: return [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11]
      case .wholetone: return [0, 2, 4, 6, 8, 10]
      case .rimKor: return [0, 2, 3, 5, 6, 8, 9, 11]
      }
    }
    
    var degrees: [UInt8?]? {
      switch self {
      case .durNatural: return [0, 2, 4, 5, 7, 9, 11]
      case .mollNatural: return [0, 2, 3, 5, 7, 8, 10]
      case .durHarmonic: return [0, 2, 4, 5, 7, 8, 11]
      case .mollHarmonic: return [0, 2, 3, 5, 7, 8, 11]
      case .durMelodic: return [0, 2, 4, 5, 7, 8, 10]
      case .mollMelodic: return [0, 2, 3, 5, 7, 9, 11]
      case .durDoubleHarmonic: return [0, 1, 4, 5, 7, 8, 11]
      case .mollDoubleHarmonic: return [0, 2, 3, 6, 7, 8, 11]
      case .durPentatonic: return [0, 2, 4, nil, 7, 9, nil]
      case .mollPentatonic: return [0, nil, 3, 5, 7, nil, 11]
      case .bluesScale: return [0, 3, 5, 6, 7, nil, 11]
      case .chromatic: return nil
      case .wholetone: return nil
      case .rimKor: return nil
      }
    }
    
    var toneSemitone: [ScaleIntervals] {
      switch self {
      case .durNatural: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      case .mollNatural: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      case .durHarmonic: return [.wTone, .wTone, .wTone, .wTone, .wTone, .aug2, .wTone]
      case .mollHarmonic: return [.wTone, .wTone, .wTone, .wTone, .wTone, .aug2, .wTone]
      case .durMelodic: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      case .mollMelodic: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      case .durDoubleHarmonic: return [.wTone, .aug2, .wTone, .wTone, .wTone, .aug2, .wTone]
      case .mollDoubleHarmonic: return [.wTone, .wTone, .aug2, .wTone, .wTone, .aug2, .wTone]
      case .durPentatonic: return [.wTone, .wTone, .mTh, .wTone, .mTh]
      case .mollPentatonic: return [.mTh, .wTone, .wTone, .mTh, .wTone]
      case .bluesScale: return [.mTh, .wTone, .hTone, .aug1, .mTh, .wTone]
      case .chromatic: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      case .wholetone: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      case .rimKor: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      }
    }
    
    enum ScaleIntervals: String {
      case hTone = "полутон"
      case wTone = "тон"
      case aug2 = "ув.2"
      case mTh = "м.3"
      case aug1 = "ув.1"
      
      var step: UInt8 {
        switch self {
        case .hTone: return 1
        case .wTone: return 2
        case .aug2: return 3
        case .mTh: return 3
        case .aug1: return 1
        }
      }
    }
    
  }
  
}
