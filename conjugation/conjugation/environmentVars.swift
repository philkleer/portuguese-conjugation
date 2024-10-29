//
// environmentVars.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 29. October 2024
// Licensed by CC-BY-NC-SA 4.0
//
import Foundation
import Combine

/// class with user settings
///
/// This class is initiated in ``MainView``. The class includes values (`Bool`) for
///  - each tense
///  - each verb group
///  - including tu in conjugation
///
///  Furthermore, it inherits the number of correct and wrong answers (`Int`):
///   - correct
///   - wrong
///
///   Initialization is for all `Bool` values false, except for  `isPresenteInd` and `regulares`. `correct` and `wrong` are intialized with `0`. 
class UserSettings: ObservableObject {
    
    @Published var correct: Int {
        didSet{
            UserDefaults.standard.set(correct, forKey: "correct")
        }
    }
    
    @Published var wrong: Int {
        didSet{
            UserDefaults.standard.set(wrong, forKey: "wrong")
        }
    }
    
    @Published var isTu: Bool {
        didSet{
            UserDefaults.standard.set(isTu, forKey: "isTu")
        }
    }
    
    @Published var irregulares: Bool {
        didSet{
            UserDefaults.standard.set(irregulares, forKey: "irregulares")
        }
    }
    
    @Published var regulares: Bool {
        didSet{
            UserDefaults.standard.set(regulares, forKey: "regulares")
        }
    }
    
    @Published var isPresenteInd: Bool {
        didSet{
            UserDefaults.standard.set(isPresenteInd, forKey: "isPresenteInd")
        }
    }
    
    @Published var isPerfeitoInd: Bool {
        didSet{
            UserDefaults.standard.set(isPerfeitoInd, forKey: "isPerfeitoInd")
        }
    }
    
    @Published var isImperfeitoInd: Bool {
        didSet{
            UserDefaults.standard.set(isImperfeitoInd, forKey: "isImperfeitoInd")
        }
    }
    @Published var isPerfeitoCompInd: Bool {
        didSet{
            UserDefaults.standard.set(isPerfeitoCompInd, forKey: "isPerfeitoCompInd")
        }
    }
    @Published var isPMQPInd: Bool {
        didSet{
            UserDefaults.standard.set(isPMQPInd, forKey: "isPMQPInd")
        }
    }
    @Published var isPMQPCompInd: Bool {
        didSet{
            UserDefaults.standard.set(isPMQPCompInd, forKey: "isPMQPCompInd")
        }
    }
    @Published var isFuturoIInd: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoIInd, forKey: "isFuturoIInd")
        }
    }
    @Published var isFuturoIIInd: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoIIInd, forKey: "isFuturoIIInd")
        }
    }
    @Published var isPresenteSub: Bool {
        didSet{
            UserDefaults.standard.set(isPresenteSub, forKey: "isPresenteSub")
        }
    }
    @Published var isPerfeitoSub: Bool {
        didSet{
            UserDefaults.standard.set(isPerfeitoSub, forKey: "isPerfeitoSub")
        }
    }
    @Published var isImperfeitoSub: Bool {
        didSet{
            UserDefaults.standard.set(isImperfeitoSub, forKey: "isImperfeitoSub")
        }
    }
    @Published var isPMQPSub: Bool {
        didSet{
            UserDefaults.standard.set(isPMQPSub, forKey: "isPMQPSub")
        }
    }
    @Published var isFuturoISub: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoISub, forKey: "isFuturoISub")
        }
    }
    @Published var isFuturoIISub: Bool {
        didSet{
            UserDefaults.standard.set(isFuturoIISub, forKey: "isFuturoIISub")
        }
    }
    @Published var isCondicionalI: Bool {
        didSet{
            UserDefaults.standard.set(isCondicionalI, forKey: "isCondicionalI")
        }
    }
    @Published var isCondicionalII: Bool {
        didSet{
            UserDefaults.standard.set(isCondicionalII, forKey: "isCondicionalII")
        }
    }
    
    init() {
        self.isPresenteInd = UserDefaults.standard.object(forKey: "isPresenteInd") as? Bool ?? true
        self.isPerfeitoInd = UserDefaults.standard.object(forKey: "isPerfeitoInd") as? Bool ?? false
        self.isImperfeitoInd = UserDefaults.standard.object(forKey: "isImperfeitoInd") as? Bool ?? false
        self.isPerfeitoCompInd = UserDefaults.standard.object(forKey: "isPerfeitoCompInd") as? Bool ?? false
        self.isPMQPInd = UserDefaults.standard.object(forKey: "isPMQPInd") as? Bool ?? false
        self.isPMQPCompInd = UserDefaults.standard.object(forKey: "isPMQPCompInd") as? Bool ?? false
        self.isFuturoIInd = UserDefaults.standard.object(forKey: "isFuturoIInd") as? Bool ?? false
        self.isFuturoIIInd = UserDefaults.standard.object(forKey: "isFuturoIIInd") as? Bool ?? false
        self.isPresenteSub = UserDefaults.standard.object(forKey: "isPresenteSub") as? Bool ?? false
        self.isPerfeitoSub = UserDefaults.standard.object(forKey: "isPerfeitoSub") as? Bool ?? false
        self.isImperfeitoSub = UserDefaults.standard.object(forKey: "isImperfeitoSub") as? Bool ?? false
        self.isPMQPSub = UserDefaults.standard.object(forKey: "isPMQPSub") as? Bool ?? false
        self.isFuturoISub = UserDefaults.standard.object(forKey: "isFuturoISub") as? Bool ?? false
        self.isFuturoIISub = UserDefaults.standard.object(forKey: "isFuturoIISub") as? Bool ?? false
        self.isCondicionalI = UserDefaults.standard.object(forKey: "isCondicionalI") as? Bool ?? false
        self.isCondicionalII = UserDefaults.standard.object(forKey: "isCondicionalII") as? Bool ?? false
        self.irregulares = UserDefaults.standard.object(forKey: "irregulares") as? Bool ?? true
        self.regulares = UserDefaults.standard.object(forKey: "regulares") as? Bool ?? true
        self.isTu = UserDefaults.standard.object(forKey: "isTu") as? Bool ?? true
        self.correct = UserDefaults.standard.object(forKey: "correct") as? Int ?? 0
        self.wrong = UserDefaults.standard.object(forKey: "wrong") as? Int ?? 0
    }
}


