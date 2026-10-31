//
//  KeyScale.swift
//  Solfegio
//
//  Created by Fedor Komov on 28.10.2026.
//

import Foundation

class KeyScale {
  var tonic: Note.WithAlteration
  var scale: Scale
  
  init(tonic: Note.WithAlteration = Note.WithAlteration(.A, alt: 0), scale: Scale) {
    self.tonic = tonic
    self.scale = scale
  }
  
  init(note: Note.WithAlteration.noteShortName = .A, alt: Int = 0, scale: Scale) {
    self.tonic = Note.WithAlteration(note, alt: alt)
    self.scale = scale
  }
  
  init(tonic: NoteName = .A, scale: Scale) {
    self.tonic = tonic.noteWithAlt
    self.scale = scale
  }
  
  func buildPitchSet() -> [UInt8] {
    let root: UInt8 = UInt8(Int(tonic.mainName.midi) + tonic.alteration)
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
  
  
  enum NoteName: String, CaseIterable, Identifiable, Hashable, Equatable {
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
    case Eis 
    case Fes
    case F
    case Fis
    case Fisis
    case Geses
    case Ges
    case G
    case Gis
    case Gisis 
    
    
    var id: String { self.rawValue }
    
    var name: String { self.rawValue }
    
    static var allKeyScaleNames: [NoteName] {
      return KeyScale.NoteName.allCases.filter { $0.isKeyScaleName }
    }
    
    var isKeyScaleName: Bool { return (alteration ∈ [-1, 0, 1]) && (self !∈ [.His, .Eis, .Fes]) }
    
    var isMollName: Bool { return (alteration ∈ [-1, 0, 1]) && (self !∈ [.His, .Eis, .Fes, .Ces, .Des, .Ges]) }
    var isDurName: Bool { return (alteration ∈ [-1, 0, 1]) && (self !∈ [.Eis, .Fes, .Gis, .Ais, .His, .Dis, .Eis]) }
    
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
      case .Eis: return 29
      case .Fes: return 28
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
    
    var noteWithAlt: Note.WithAlteration {
      return Note.WithAlteration(self.mainNote, alt: self.alteration)
    }
    
    var mainNote: Note.WithAlteration.noteShortName {
      switch self {
      case .Ases: return .A
      case .As: return .A
      case .A: return .A
      case .Ais: return .A
      case .Aisis: return .A
      case .Bes: return .H
      case .B: return .B
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
      case .Eis: return .E
      case .Fes: return .F
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
    
    var nameWithSign: String {
      var sign: String = ""
      switch alteration {
      case ..<0: sign = String(repeating: "♭", count: -alteration)
      case 1...: sign = String(repeating: "𝄪", count: alteration / 2) + String(repeating: "♯", count: alteration % 2)
      default: sign = ""
      }
      return "\(self.mainNote)\(sign)" 
    }
    
    var alteration: Int {
      switch self {
      case .Ases: return -2
      case .As: return -1
      case .A: return 0
      case .Ais: return 1
      case .Aisis: return 2
      case .Bes: return -2
      case .B: return 0
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
      case .Eis: return 1
      case .Fes: return -1
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
  
  
  
  enum Scale: String, CaseIterable, Identifiable {
    case durNatural
    case durHarmonic
    case durMelodic
    case durDoubleHarmonic
    case durPentatonic
    case mollNatural
    case mollHarmonic
    case mollMelodic
    case mollDoubleHarmonic
    case mollPentatonic
    case bluesScale
    case chromatic
    case wholetone
    case rimKor
    
    var id: String { self.rawValue }
    
    var buildMidi: [UInt8] {
      switch self {
      case .durNatural: return [0, 2, 4, 5, 7, 9, 11]
      case .durHarmonic: return [0, 2, 4, 5, 7, 8, 11]
      case .durMelodic: return [0, 2, 4, 5, 7, 8, 10]
      case .durDoubleHarmonic: return [0, 1, 4, 5, 7, 8, 11]
      case .durPentatonic: return [0, 2, 4, 7, 9]
      case .mollNatural: return [0, 2, 3, 5, 7, 8, 10]
      case .mollHarmonic: return [0, 2, 3, 5, 7, 8, 11]
      case .mollMelodic: return [0, 2, 3, 5, 7, 9, 11]
      case .mollDoubleHarmonic: return [0, 2, 3, 6, 7, 8, 11]
      case .mollPentatonic: return [0, 3, 5, 7, 10]
      case .bluesScale: return [0, 3, 5, 6, 7, 10]
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
    
    var name: String {
      switch self {
      case .durNatural: "-dur нат."
      case .mollNatural: "-moll нат."
      case .durHarmonic: "-dur гарм."
      case .mollHarmonic: "-moll гарм."
      case .durMelodic: "-dur мел."
      case .mollMelodic: "-moll мел."
      case .durDoubleHarmonic: "-dur дв. гарм"
      case .mollDoubleHarmonic: "-moll дв. гарм"
      case .durPentatonic: "-dur пентатоника"
      case .mollPentatonic: "-moll пентатоника"
      case .bluesScale: " блюзовая"
      case .chromatic: " хоматическая"
      case .wholetone: " целотоновая"
      case .rimKor: " уменьшенный"
      }
    }
    
    var firstLowCase: Bool { return name.starts(with: "-moll") }
    
    var toneSemitone: [ScaleIntervals] {
      switch self {
      case .durNatural: return [.wTone, .wTone, .hTone, .wTone, .wTone, .wTone, .hTone]
      case .mollNatural: return [.wTone, .hTone, .wTone, .wTone, .hTone, .wTone, .wTone]
      case .durHarmonic: return [.wTone, .wTone, .hTone, .wTone, .hTone, .aug2, .hTone]
      case .mollHarmonic: return [.wTone, .hTone, .wTone, .wTone, .hTone, .aug2, .hTone]
      case .durMelodic: return [.wTone, .wTone, .hTone, .wTone, .hTone, .wTone, .wTone]
      case .mollMelodic: return [.wTone, .hTone, .wTone, .wTone, .wTone, .wTone, .hTone]
      case .durDoubleHarmonic: return [.hTone, .aug2, .hTone, .wTone, .hTone, .aug2, .hTone]
      case .mollDoubleHarmonic: return [.wTone, .hTone, .aug2, .hTone, .hTone, .aug2, .hTone]
      case .durPentatonic: return [.wTone, .wTone, .mTh, .wTone, .mTh]
      case .mollPentatonic: return [.mTh, .wTone, .wTone, .mTh, .wTone]
      case .bluesScale: return [.mTh, .wTone, .hTone, .aug1, .mTh, .wTone]
      case .chromatic: return [.hTone, .hTone, .hTone, .hTone, .hTone, .hTone, .hTone, .hTone, .hTone, .hTone, .hTone, .hTone]
      case .wholetone: return [.wTone, .wTone, .wTone, .wTone, .wTone, .wTone]
      case .rimKor: return [.wTone, .hTone, .wTone, .hTone, .wTone, .hTone, .wTone, .hTone]
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
    
    enum Degree {
      case I, II, III, IV, V, VI, VII
    }
  }
  
}

extension Int {
  var toNote: KeyScale.NoteName? {
    guard self ∈ (0...127) else { return nil }
    let n = self % 12
    switch n {
    case 0: return .C
    case 1: return .Cis
    case 2: return .D
    case 3: return .Es
    case 4: return .E
    case 5: return .F
    case 6: return .Fis
    case 7: return .G
    case 8: return .As
    case 9: return .A
    case 10: return .B
    case 11: return .H
    default: return nil
    }
  }
}


