//
// trainView.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 11. November 2024
// Licensed by CC-BY-NC-SA 4.0
//

import SwiftUI


struct trainView: View {
    /// value of the targetted person (`Int`)
    ///  
    /// The value is used to indicate the targetted person for the conjugation. It is used in ``trainTarget(pessoa:numero:caso:verbo:)`` and set in ``newRound()`` resp. is the return value of ``setPerson()`` in ``newRound()``.
    ///  
    /// ```swift
    /// @State var person: Int = 1
    /// ```
    @State var person: Int = 1
    
    /// text of the targetted person (`String`)
    ///
    /// This value is a strong shown in the training to make it easier to identify the person of conjugation. It is  set in ``newRound()``.
    ///
    /// ```swift
    /// @State var personText: String = "Eu"
    /// ```
    @State var personText: String = "Eu"
    
    /// value of the targetted modus for the conjugation (`String`)
    ///  
    /// This value is used to indicate the targetted modus for the conjugation. It is used in ``trainTarget(pessoa:numero:caso:verbo:)`` and set in ``newRound()`` resp. is the return value of ``setNumerus()`` in ``newRound()``.
    ///   
    /// ```swift
    /// @State var numerus: String = "singular"
    /// ```
    @State var numerus: String = "singular"
        
    /// value of targetted tense for each training (`String`)
    ///
    /// This value is used to indicate the targetted modus for the conjugation. It is used in ``trainTarget(pessoa:numero:caso:verbo:)`` and set in ``newRound()`` resp. is the return value of ``setTense()`` in ``newRound()``..
    ///
    /// ```swift
    /// @State var tense: String = "Presente Indicativo"
    /// ```
    @State var tense: String = "Presente Indicativo"
    
    /// value of targetted verb for each training (`String`)
    ///
    /// This value is used to indicate the targetted modus for the conjugation. It is used in ``trainTarget(pessoa:numero:caso:verbo:)`` and set in ``newRound()`` resp. is the return value of ``setVerb()`` in ``newRound()``.
    ///
    /// ```swift
    /// @State var verb: String = "fazer"
    /// ```
    @State var verb: String = "fazer"
      
    /// `Array<String>` that inherits the verb to test from ``verbArray`` resp. ``verbIrrArray``.
    ///
    /// This array is used in ``trainTarget(pessoa:numero:caso:verbo:)`` and is resetted in ``newRound()``. It's initalized with "fazer".
    ///
    /// ```swift
    /// @State var verbHelper: Array<String> = ["fazer", "fazer"]
    /// ```
    @State var verbHelper: Array<String> = ["fazer", "fazer"]
    
    /// text input from user
    ///
    /// This value is the text input by the user. The value is used in ``proof(entrada:alvo:)`` and is reset in ``newRound()``.
    ///
    /// ```swift
    /// @State var hint: String = ""
    /// ```
    @State var hint: String = ""
    
    /// value that is the target in each conjugation trial
    ///
    /// The value is created by ``trainTarget(pessoa:numero:caso:verbo:)``. This value is used in ``proof(entrada:alvo:)`` and ``createAlertMessage(resultado:alvo:)``.
    ///
    /// ```swift
    /// @State var target: String = ""
    /// ```
    @State var target: String = ""
    
    /// value to show message (`Bool`)
    ///
    /// This value sets the result message to the user in the view (`.onCommit`) and starts a new round for training.
    /// ```swift
    /// @State private var showingAlert = false
    /// ```
    @State private var showingAlert = false
    
    /// stores the result out of ``proof(entrada:alvo:)`` (`Bool`)
    ///
    /// The value is used in the function ``createAlertMessage(resultado:alvo:)`` to create a message depending on a correct or wrong result.
    ///
    /// ```swift
    /// @State var result: Bool = false
    /// ```
    @State var result: Bool = false
    
    /// stores the result of ``createAlertMessage(resultado:alvo:)`` (`String`)
    ///
    /// The value is used in the ``trainPage`` view to present the message after the user clicks on the button to test his hin against the result.
    ///
    /// ```swift
    /// @State var message: String = ""
    /// ```
    @State var message: String = ""
    
    /// array of used tenses in the conjugation training (`[String]`)
    ///
    /// It is used in ``setTense()`` to not repeat a tense too often.
    ///
    /// ```swift
    /// @State var lastTenses: [String] = []
    /// ```
    @State var lastTenses: [String] = []
    
    /// value to count for position in ``lastTenses`` (`Int`)
    ///
    /// ```swift
    /// @State var countTense: Int = 0
    /// ```
    @State var countTense: Int = 0
  
    /// array of last verbs conjugated (`[String]`)
    ///
    /// `lastVerbs` is an array of verbs used in prior conjugation trials. It is used to cross-check that a specific verb is not re-used too frequently (see ``setVerb()``).
    ///
    /// ```swift
    /// @State var lastVerbs: [String] = []
    /// ```
    @State var lastVerbs: [String] = []
        
    /// defines the length of the 2-dimensional verb array used in ``setVerb()``. (`Int`)
    ///
    /// It is defined in ``setVerbArray(irregular:regular:)`` depending on the user's choices of verbs (regular and/or irregular). It is used in ``setVerb()``.
    ///
    /// ```swift
    /// @State var countVerbArray: Int = 0
    /// ```
    @State var countVerbArray: Int = 0
    
    /// is a environment variable that transfer specific values across views. It is instantiaded in view ``MainView`` and defined in class ``UserSettings``.
    ///
    ///```swift
    /// @EnvironmentObject var userSettings: UserSettings
    /// ```
    @EnvironmentObject var userSettings: UserSettings
    
    /// controls the focus on the TextField (`Bool`)
    ///
    ///  The value controls the text field (``hint``) where the user types his answer. The field will be automatically focused when the view appears.
    ///
    /// ```swift
    /// @FocusState private var isTextFocused: Bool
    /// ```
    @FocusState private var isTextFocused: Bool
    
    /// a 2-dimensional array of the regular verbs
    ///
    /// This is the 2-dimensional array of the regular verbs included each regular conjugation type (ar, er, ir). There are 15 verbs per conjugation type.
    /// Example:
    /// ```swift
    ///let verbArray = [
    ///     ["acordar", "ar"],
    ///     ["comprar", "ar"],
    ///     ...
    ///     ["correr", "er"],
    ///     ["encher", "er"],
    ///     ...
    ///     ["abrir", "ir"],
    ///     ["assistir", "ir"],
    ///     ...
    /// ]
    /// ```
    let verbArray = [
        // ar verbs (15 verbs)
        ["acordar", "ar"],
        ["comprar", "ar"],
        ["comprar", "ar"],
        ["cuidar", "ar"],
        ["detestar", "ar"],
        ["deitar", "ar"],
        ["falar", "ar"],
        ["gostar", "ar"],
        ["levar", "ar"],
        ["limpar", "ar"],
        ["melhorar", "ar"],
        ["pagar", "ar"],
        ["pensar", "ar"],
        ["procurar", "ar"],
        ["significar", "ar"],
        ["tornar", "ar"],
        // er verbs (15 verbs)
        ["aprender", "er"],
        ["acontecer", "er"],
        ["bater", "er"],
        ["beber", "er"],
        ["comer", "er"],
        ["conhecer", "er"],
        ["correr", "er"],
        ["encher", "er"],
        ["entender", "er"],
        ["escolher", "er"],
        ["escrever", "er"],
        ["ler", "er"],
        ["receber", "er"],
        ["responder", "er"],
        ["vender", "er"],
        // ir verbs (15 verbs)
        ["abrir", "ir"],
        ["assistir", "ir"],
        ["decidir", "ir"],
        ["desistir", "ir"],
        ["discutir", "ir"],
        ["dividir", "ir"],
        ["dormir", "ir"],
        ["existir", "ir"],
        ["insistir", "ir"],
        ["mentir", "ir"],
        ["partir", "ir"],
        ["permitir", "ir"],
        ["proibir", "ir"],
        ["sentir", "ir"],
        ["servir", "ir"]
    ]
    
    
    /// a 2-dimensional array of irregular verbs
    ///
    ///This is the 2-dimensional array of irregular verbs. The array contains 18 entries.
    /// Example:
    /// ```swift
    ///let verbIrrArray = [
    /// ["estar", "estar"],
    /// ["ir", "ira"],
    /// ...
    /// ]
    /// ```
    let verbIrrArray = [
        ["estar", "estar"],
        ["ir", "ira"],
        ["fazer", "fazer"],
        ["perder", "er"],
        ["poder", "poder"],
        ["pôr", "por"],
        ["querer", "querer"],
        ["saber", "saber"],
        ["ser", "ser"],
        ["trazer", "trazer"],
        ["ter", "ter"],
        ["ver", "ver"],
        ["vir", "vir"],
        // only some differences form er
        ["dizer", "er"],
        // ear (only some differences from ar)
        ["passear", "ar"],
        ["sortear", "ar"],
        // air (only some differences from ir)
        ["cair", "ir"],
        ["sair", "ir"]
        
    ]
    
    /// creates the training View
    ///
    ///This view creates the training view, in which the user trains the conjugation. It uses the ``CustomNavBar`` with a different title and settings for icons:
    ///
    /// ```swift
    ///.customNavigationTitle("Treino")
    ///.customNavigationBackButtonHidden(true)
    ///.customNavigationResetHidden(false)
    ///.customNavigationOptionsHidden(false)
    /// ```
    ///
    /// On appear this view is initiate with the function ``newRound()``.
    var body: some View {
        VStack(spacing: 0) {
            VStack() {
                Text("Correto: " + String(userSettings.correct) + " / Falso: " + String(userSettings.wrong))
                    .foregroundColor(Color("textcolor"))
                    .font(.headline)
                    .padding(.top, 10)
                    .padding(.bottom, 15)
            }
            
            VStack() {
                Text("Forme a conjugação de ...")
                    .padding(0.0)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(Color("textcolor"))
                    .frame(width: 350)
                
                Text(String(verb))
                    .font(.title2)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color("textcolor"))
                    .padding(.bottom, 20)
                
                let message = "na " + String(person) + "ª pessoa " + numerus + " (" + personText + ")"
                
                Text(message)
                    .padding(.bottom, 15)
                    .font(.title2)
                    .foregroundColor(Color("textcolor"))
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
                
                Text("de " + String(tense))
                    .padding(.bottom, 15)
                    .font(.title2)
                    .foregroundColor(Color("textcolor"))
                    .frame(width: 350)
                    .multilineTextAlignment(.center)
            }.frame(maxHeight: .infinity)
            
            VStack() {
                TextField(
                    "Digite sua dica!",
                    text: $hint,
                    onCommit: {
                        showingAlert = true
                        target = trainTarget(pessoa: person, numero: numerus, caso: tense, verbo: verbHelper)
                        result = proof(entrada: hint, alvo: target)
                        message = createAlertMessage(resultado: result, alvo: target)
                        if showingAlert == false {newRound()}
                        isTextFocused = false
                    }
                )
                .padding(.all, 5)
                .disableAutocorrection(true)
                .multilineTextAlignment(.center)
                .autocapitalization(.none)
                .font(.title)
                .focused($isTextFocused)
                
                Button("Teste") {
                    showingAlert = true
                    target = trainTarget(pessoa: person, numero: numerus, caso: tense, verbo: verbHelper)
                    result = proof(entrada: hint, alvo: target)
                    message = createAlertMessage(resultado: result, alvo: target)
                    if showingAlert == false {
                        newRound()
                        hint = ""
                    }
                    isTextFocused = false
                }
                .font(.title2)
                .padding(.bottom, 20)
                .disabled(hint == "")
                .alert(isPresented:$showingAlert) {
                    if (result == false) {
                        Alert(
                            title: Text(message),
                            primaryButton:.default(Text("Que pena! ☹️")) {
                                newRound()
                                hint = ""
                                userSettings.wrong = userSettings.wrong + 1
                            },
                            secondaryButton:
                                    .destructive(Text("Erro de digitação! 🤦🏽‍♂️")) {
                                        newRound()
                                        userSettings.correct = userSettings.correct + 1
                                    }
                        )
                    } else {
                        Alert(
                            title: Text(message),
                            dismissButton: .cancel(Text("Joia! 👍🏾")) {
                                newRound()
                                userSettings.correct = userSettings.correct + 1
                            }
                        )
                    }
                }
                .font(.title)
                .foregroundColor(Color("textcolor"))
            }
            
//            Spacer()
//                .frame(minHeight: 0, maxHeight: 50)

        }.onAppear{newRound()}
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background"))
        .customNavigationTitle("Treino")
        .customNavigationBackButtonHidden(true)
        .customNavigationResetHidden(false)
        .customNavigationOptionsHidden(false)
    }
    
    /// sets the person to conjugate
    ///
    /// This function randomly selects the person to conjugate. Depending on the user's choice in ``setOptions`` it includes the conjugation for the second person or not.
    /// - Returns: Integer that represents the person to train.
    func setPerson() -> (Int) {
        var personArray = [1, 3]
        if (userSettings.isTu == true) {
            //        if (self.userSettings.isTu == true) {
            personArray = [1, 2, 3]
        }
        let hilfePerson = personArray.randomElement()!
        return(hilfePerson)
    }
    
    /// sets the modus to conjugate (singular or plural)
    ///
    /// This function randomly selects the modus for the conjugation (singular or plural) and returns a `String` for the selection (`singular` or `plural`).
    /// - Returns: a `String` that indicates the modus (singular or plural)
    func setNumerus() -> (String) {
        let numerusArray = ["singular", "plural"]
        
        let hilfeAnzahl = numerusArray.randomElement()!
        
        return(hilfeAnzahl)
    }
    
    /// selects the tense for the user training
    ///
    /// First, the function builds depending on the user's input (toggles in ``setOptions``) an array (``allTense``) with the possible tenses for the user's training. Second, it selects the specific tense to train in the next round (``trainTense``). In the selection of the next round, it regards which tenses were trained prior so that tenses are not too frequently repeated (it uses ``lastCase`` and ``countTense``)
    /// - Returns: the tense to train (`String`)
    func setTense() -> (String) {
        var trainZeit: String = ""
        var alleZeiten: Array<String> = []
        
        if (userSettings.isPresenteInd == false) {
            //        if (self.userSettings.isPresenteInd == false) {
            if (alleZeiten.contains("Presente Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Presente Indicativo")!)
            }
        }
        if (userSettings.isPresenteInd == true) {
            //        if (self.userSettings.isPresenteInd == true) {
            if !(alleZeiten.contains("Presente Indicativo")) {
                alleZeiten.append("Presente Indicativo")
            }
        }
        if (userSettings.isPerfeitoInd == false) {
            //        if (self.userSettings.isPerfeitoInd == false) {
            if (alleZeiten.contains("Pretérito Perfeito Simples Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Perfeito Simples Indicativo")!)
            }
        }
        if (userSettings.isPerfeitoInd == true) {
            //        if (self.userSettings.isPerfeitoInd == true) {
            if !(alleZeiten.contains("Pretérito Perfeito Simples Indicativo")) {
                alleZeiten.append("Pretérito Perfeito Simples Indicativo")
            }
        }
        if (userSettings.isImperfeitoInd == false) {
            //        if (self.userSettings.isImperfeitoInd == false) {
            if (alleZeiten.contains("Pretérito Imperfeito Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Imperfeito Indicativo")!)
            }
        }
        if (userSettings.isImperfeitoInd == true) {
            //        if (self.userSettings.isImperfeitoInd == true) {
            if !(alleZeiten.contains("Pretérito Imperfeito Indicativo")) {
                alleZeiten.append("Pretérito Imperfeito Indicativo")
            }
        }
        if (userSettings.isPerfeitoCompInd == false) {
            //        if (self.userSettings.isPerfeitoCompInd == false) {
            if (alleZeiten.contains("Pretérito Perfeito Composto Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Perfeito Composto Indicativo")!)
            }
        }
        if (userSettings.isPerfeitoCompInd == true) {
            //        if (self.userSettings.isPerfeitoCompInd == true) {
            if !(alleZeiten.contains("Pretérito Perfeito Composto Indicativo")) {
                alleZeiten.append("Pretérito Perfeito Composto Indicativo")
            }
        }
        if (userSettings.isPMQPCompInd == false) {
            //        if (self.userSettings.isPMQPCompInd == false) {
            if (alleZeiten.contains("Pretérito Mais-que-Perfeito Composto Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Mais-que-Perfeito Composto Indicativo")!)
            }
        }
        if (userSettings.isPMQPCompInd == true) {
            //        if (self.userSettings.isPMQPCompInd == true) {
            if !(alleZeiten.contains("Pretérito Mais-que-Perfeito Composto Indicativo")) {
                alleZeiten.append("Pretérito Mais-que-Perfeito Composto Indicativo")
            }
        }
        if (userSettings.isPMQPInd == false) {
            //        if (self.userSettings.isPMQPInd == false) {
            if (alleZeiten.contains("Pretérito Mais-que-Perfeito Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Mais-que-Perfeito Indicativo")!)
            }
        }
        if (userSettings.isPMQPInd == true) {
            //        if (self.userSettings.isPMQPInd == true) {
            if !(alleZeiten.contains("Pretérito Mais-que-Perfeito Indicativo")) {
                alleZeiten.append("Pretérito Mais-que-Perfeito Indicativo")
            }
        }
        if (userSettings.isFuturoIInd == false) {
            //        if (self.userSettings.isFuturoIInd == false) {
            if (alleZeiten.contains("Futuro Simples Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Futuro Simples Indicativo")!)
            }
        }
        if (userSettings.isFuturoIInd == true) {
            //        if (self.userSettings.isFuturoIInd == true) {
            if !(alleZeiten.contains("Futuro Simples Indicativo")) {
                alleZeiten.append("Futuro Simples Indicativo")
            }
        }
        if (userSettings.isFuturoIIInd == false) {
            //        if (self.userSettings.isFuturoIIInd == false) {
            if (alleZeiten.contains("Futuro Composto Indicativo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Futuro Composto Indicativo")!)
            }
        }
        if (userSettings.isFuturoIIInd == true) {
            //        if (self.userSettings.isFuturoIIInd == true) {
            if !(alleZeiten.contains("Futuro Composto Indicativo")) {
                alleZeiten.append("Futuro Composto Indicativo")
            }
        }
        if (userSettings.isPresenteSub == false) {
            //        if (self.userSettings.isPresenteSub == false) {
            if (alleZeiten.contains("Presente Subjuntivo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Presente Subjuntivo")!)
            }
        }
        if (userSettings.isPresenteSub == true) {
            //        if (self.userSettings.isPresenteSub == true) {
            if !(alleZeiten.contains("Presente Subjuntivo")) {
                alleZeiten.append("Presente Subjuntivo")
            }
        }
        if (userSettings.isPerfeitoSub == false) {
            //        if (self.userSettings.isPerfeitoSub == false) {
            if (alleZeiten.contains("Pretérito Perfeito Simples Subjuntivo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Perfeito Simples Subjuntivo")!)
            }
        }
        if (userSettings.isPerfeitoSub == true) {
            //        if (self.userSettings.isPerfeitoSub == true) {
            if !(alleZeiten.contains("Pretérito Perfeito Simples Subjuntivo")) {
                alleZeiten.append("Pretérito Perfeito Simples Subjuntivo")
            }
        }
        if (userSettings.isImperfeitoSub == false) {
            //        if (self.userSettings.isImperfeitoSub == false) {
            if (alleZeiten.contains("Pretérito Imperfeito Subjuntivo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Imperfeito Subjuntivo")!)
            }
        }
        if (userSettings.isImperfeitoSub == true) {
            //        if (self.userSettings.isImperfeitoSub == true) {
            if !(alleZeiten.contains("Pretérito Imperfeito Subjuntivo")) {
                alleZeiten.append("Pretérito Imperfeito Subjuntivo")
            }
        }
        if (userSettings.isPMQPSub == false) {
            //        if (self.userSettings.isPMQPSub == false) {
            if (alleZeiten.contains("Pretérito Mais-que-Perfeito Subjuntivo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Pretérito Mais-que-Perfeito Subjuntivo")!)
            }
        }
        if (userSettings.isPMQPSub == true) {
            //        if (self.userSettings.isPMQPSub == true) {
            if !(alleZeiten.contains("Pretérito Mais-que-Perfeito Subjuntivo")) {
                alleZeiten.append("Pretérito Mais-que-Perfeito Subjuntivo")
            }
        }
        if (userSettings.isFuturoISub == false) {
            //        if (self.userSettings.isFuturoISub == false) {
            if (alleZeiten.contains("Futuro Simples Subjuntivo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Futuro Simples Subjuntivo")!)
            }
        }
        if (userSettings.isFuturoISub == true) {
            //        if (self.userSettings.isFuturoISub == true) {
            if !(alleZeiten.contains("Futuro Simples Subjuntivo")) {
                alleZeiten.append("Futuro Simples Subjuntivo")
            }
        }
        if (userSettings.isFuturoIISub == false) {
            //        if (self.userSettings.isFuturoIISub == false) {
            if (alleZeiten.contains("Futuro Composto Subjuntivo")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Futuro Composto Subjuntivo")!)
            }
        }
        if (userSettings.isFuturoIISub == true) {
            //        if (self.userSettings.isFuturoIISub == true) {
            if !(alleZeiten.contains("Futuro Composto Subjuntivo")) {
                alleZeiten.append("Futuro Composto Subjuntivo")
            }
        }
        if (userSettings.isCondicionalI == false) {
            //        if (self.userSettings.isCondicionalI == false) {
            if (alleZeiten.contains("Futuro do Préterito (Condicional I)")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Futuro do Préterito (Condicional I)")!)
            }
        }
        if (userSettings.isCondicionalI == true) {
            //        if (self.userSettings.isCondicionalI == true) {
            if !(alleZeiten.contains("Futuro do Préterito (Condicional I)")) {
                alleZeiten.append("Futuro do Préterito (Condicional I)")
            }
        }
        if (userSettings.isCondicionalII == false) {
            //        if (self.userSettings.isCondicionalII == false) {
            if (alleZeiten.contains("Futuro do Préterito Composto (Condicional II)")) {
                alleZeiten.remove(at: alleZeiten.firstIndex(of: "Futuro do Préterito Composto (Condicional II)")!)
            }
        }
        if (userSettings.isCondicionalII == true) {
            //        if (self.userSettings.isCondicionalII == true) {
            if !(alleZeiten.contains("Futuro do Préterito Composto (Condicional II)")) {
                alleZeiten.append("Futuro do Préterito Composto (Condicional II)")
            }
        }
        
        if (alleZeiten.count >= 3) {
            countTense = Int(alleZeiten.count - (alleZeiten.count / 3))
        }
                
        // if more more than 3 cases control for not too frequent repitition of tense
        if (alleZeiten.count >= 3) {
            if (lastTenses == []) {
                trainZeit = alleZeiten.randomElement()!
                lastTenses.append(trainZeit)
            } else if (lastTenses.count < countTense) {
                repeat {
                    trainZeit = alleZeiten.randomElement()!
                } while (lastTenses.contains(trainZeit))
                lastTenses.append(trainZeit)
            } else {
                lastTenses.remove(at: 0)
                repeat {
                    trainZeit = alleZeiten.randomElement()!
                } while (lastTenses.contains(trainZeit))
                lastTenses.append(trainZeit)
            }
        } else {
          trainZeit = alleZeiten.randomElement()!
        }
        return(trainZeit)
    }
    
    // function to set verb array
    /// it selects the training verb array out of the by the user selected verbs (``userSettings.regulares`` and ``userSettings.irregulares``).
    /// - Parameters:
    ///   - irregular: input of irregular verbs (2-dimensional array ``verbIrrArray``)
    ///   - regular: input of regular verbs (2-dimensional array ``verbArray``)
    /// - Returns: a 2-dimensional array of possible verbs (by user selection) that are used for the conjugation training.
    func setVerbArray(irregular: [[String]], regular: [[String]]) -> ([[String]]) {
        var verbHilfeArray: [[String]]
        if (userSettings.irregulares == true && userSettings.regulares == false) {
            verbHilfeArray = verbIrrArray
            // to not repeat verbs to often
            countVerbArray = verbHilfeArray.count - Int((verbHilfeArray.count / 3))
        } else if (userSettings.irregulares == false && userSettings.regulares == true) {
            verbHilfeArray = verbArray
            // to not repeat verbs to often
            countVerbArray = verbHilfeArray.count - Int((verbHilfeArray.count / 3))
        } else {
            verbHilfeArray = verbArray + verbIrrArray
            // to not repeat verbs to often
            countVerbArray = verbHilfeArray.count - Int((verbHilfeArray.count / 3))
        }
        return(verbHilfeArray)
    }
    
    /// selects the verb array to conjugate
    ///
    /// This functions selects the verbArray out of the possible cases depending on user's input in ``setOptions`` (conjugation of tu, which tenses, regular and/or irregular verbs). It first builds a new array depending on the user's choices of possible verbs and then selects randomly which verb will be conjugated. However, to not repeat verbs to often, it checks against the array of last verbs to not repeat verbs to often and to have variation. It uses ``lastVerbs``.
    /// - Returns: the verb array that is used to build the conjugation target.
    func setVerb() -> (Array<String>) {
        var trainVerb: [String] = []
        let alleVerben = setVerbArray(irregular: verbIrrArray, regular: verbArray)
        // case: verbs are irregular and regular or only irregular
        if (lastVerbs == []) {
            trainVerb = alleVerben.randomElement()!
            lastVerbs.append(trainVerb[0])
        } else if (lastVerbs.count < countVerbArray) {
            trainVerb = alleVerben.randomElement()!
            while (lastVerbs.contains(trainVerb[0])) {
                trainVerb = alleVerben.randomElement()!
            }
            lastVerbs.append(trainVerb[0])
        } else {
            lastVerbs.remove(at: 0)
            trainVerb = alleVerben.randomElement()!
            while (lastVerbs.contains(trainVerb[0])) {
                trainVerb = alleVerben.randomElement()!
            }
            lastVerbs.append(trainVerb[0])
        }
        return (trainVerb)
    }
    
    /// Initiates  a new conjugation round
    ///
    /// This function is wrapper function around the functions ``setPerson()``, ``setNumerus``, ``setTense()`` and ``setVerb()`` and stores it into the variables ``person``, ``numerus``, ``tense``, ``verbHelper``,  ``verb``, and ``hint``. It builds new values for the new conjugation target and sets the user's input (`hint`) back to an empty string.
    ///
    ///
    /// Code:
    /// ```swift
    /// func newRound(){
    ///     person = setPerson()
    ///     numerus = setNumerus()
    ///     tense = setTense()
    ///     verbHelper = setVerb()
    ///     verb = verbHelper[0]
    ///     hint = ""
    /// }
    /// ```
    func newRound(){
        person = setPerson()
        numerus = setNumerus()
        tense = setTense()
        verbHelper = setVerb()
        verb = verbHelper[0]
        hint = ""
        if (numerus == "plural") {
            if (person == 1) {
                personText = "Nós"
            } else if (person == 2) {
                personText = "Vós"
            } else {
                personText = "Eles/Elas/Vocês"
            }
        } else {
            if (person == 1) {
                personText = "Eu"
            } else if (person == 2) {
                personText = "Tu"
            } else {
                personText = "Ele/Ela/Você"
            }
        }
    }
}


/// builds the conjugated verb ``target``
///
/// This function takes as inputs the necessary infos to build the conjugation (`verbo`, `pessoa`, `numero`, `caso`, `verbo`) and builds the conjugated verb in its intended form. The result is returned as `String`.
///
/// Within this function, we build arrays (`Array<String>`) for necessary auxiliary verbs, for conjugation person's endings (`Array<String>`) and direc result arrays for irregular verbs (`Array<String>`). For the irregular verbs, only the cases that differ are included in the result arrays for irregluar verbs.
///
/// Example of declaration for auxiliary verbs:
/// ```swift
/// // Futuro Composto
/// let futcomHv = ["terei", "teras", "terá", "teremos", "tereis", "terão"]
/// // Perfeito Subjuntivo
///let perfeitoSubHv = ["tenha", "tenhas", "tenha", "tenhamos", "tenhais", "tenham"]
/// ```
///
/// Example for declaration of conjugation person's ending (regular and irregular):
/// ```swift
/// // Pretérito Perfeito Indicativo
/// let perfeitoAr = ["ei", "aste", "ou", "amos", "astes", "aram"]
/// let perfeitoEr = ["i", "este", "eu", "emos", "estes", "eram"]
/// let perfeitoIr = ["i", "iste", "iu", "imos", "istes", "iram"]
/// let perfeitoAir = ["í", "íste", "iu", "ímos", "ístes", "íram"]
/// let perfeitoSer = ["fui", "foste", "foi", "fomos", "fostes", "foram"]
/// let perfeitoEstar = ["estive", "estiveste", "esteve", "estivemos", "estivestes", "estiveram"]
/// ```
///
/// In some cases it uses ``buildPerfeitoHelper(entrada:cair:)`` or ``buildPresenteHelper(entrada:cair:)``.
///
/// - Parameters:
///   - pessoa: indicated person of conjugation (`Int`)
///   - numero: indicated modus of conjugation (`String`)
///   - caso: indicated tense of conjugation (`String`)
///   - verbo: verb array to build the conjugation from (`Array<String>`)
/// - Returns: returns the correct conjugation version of the indicated `verbo` depending on `pessoa`, `numero`, `caso` as `String`
func trainTarget(pessoa: Int, numero: String, caso: String, verbo: Array<String>) -> String {
    var ziel: String = ""
    var stamm: String = ""
    var hilfsverb: String = ""
    var hilfsverbPerfeito: String = ""
    var nummerInArray: Int = 0
    
    // auxiliary verbs
    // Perfeito Composto
    let ppcHv = ["tenho", "tens", "tem", "temos", "tendes", "têm"]
    // Pretértio Mais-que-Perfeito Composto
    let pmqpHv = ["tinha", "tinhas", "tinha", "tínhamos", "tínheis", "tinham"]
    // Futuro Composto
    let futcomHv = ["terei", "teras", "terá", "teremos", "tereis", "terão"]
    // Perfeito Subjuntivo
    let perfeitoSubHv = ["tenha", "tenhas", "tenha", "tenhamos", "tenhais", "tenham"]
    // Pretérito Mais-que-Perfeito Composto Subjuntivo
    let pmqpCompSubHv = ["tivesse", "tivesses", "tivesse", "tivéssemos", "tívesseis", "tivessem"]
    // Futuro Composto Subjuntivo
    let futuroCompSubHv = ["tiver", "tiveres", "tiver", "tivermos", "tiverdes", "tiverem"]
    // Condicional II
    let condIIHv = ["teria", "terias", "teria", "teríamos", "teríeis", "teriam"]
    
    // Conjugation arrays (depending on person 1-2-3-1-2-3)
    // Presente Indicativo
    let presenteAr = ["o", "as", "a", "amos", "ais", "am"]
    let presenteEr = ["o", "es", "e", "emos", "eis", "em"]
    let presenteIr = ["o", "es", "e", "imos", "is", "em"]
    // partly irregular
    let presenteEar = ["io", "ias", "ia", "amos", "ais", "iam"]
    // first and third person singular (er)
    let presenteFazer = ["faço", "---", "faz", "---", "---", "---"]
    let presenteDizer = ["digo", "---", "diz", "---", "---", "---"]
    let presenteTrazer = ["trago", "---", "traz", "---", "---", "---"]
    // only thirs person (er)
    let presenteQuerer = ["---", "---", "quer", "---", "---", "---"]
    // dormir, only first person (ir)
    let presenteDormir = ["durmo", "---", "---", "---", "---", "---"]
    let presenteEntir = ["into", "---", "---", "---", "---", "---"]
    let presenteErvir = ["irvo", "---", "---", "---", "---", "---"]
    let presenteAir = ["aio", "ais", "ai", "aímos", "aís", "aem"]
    // only first person (er)
    let presenteCer = ["ço", "---", "---", "---", "---", "---"]
    let presenteSaber = ["sei", "---", "---", "---", "---", "---"]
    let presentePoder = ["posso", "---", "---", "---", "---", "---"]
    let presentePerder = ["perco", "---", "---", "---", "---", "---"]
    // completely irregular
    let presenteSer = ["sou", "és", "é", "somos", "sois", "são"]
    let presenteEstar = ["estou", "estás", "está", "estamos", "estais", "estão"]
    let presenteIra = ["vou", "vais", "vai", "vamos", "ides", "vão"]
    let presenteVir = ["venho", "vens", "vem", "vimos", "vindes", "vêm"]
    let presenteVer = ["vejo", "vês", "vê", "vemos", "vedes", "vêem"]
    let presenteTer = ["tenho", "tens", "tem", "temos", "tendes", "têm"]
    let presenteLer = ["leio", "lês", "lê", "lemos", "ledes", "leem"]
    let presentePor = ["ponho", "pões", "põe", "pomos", "pondes", "põem"]
    
    // Pretérito Perfeito Indicativo
    let perfeitoAr = ["ei", "aste", "ou", "amos", "astes", "aram"]
    let perfeitoEr = ["i", "este", "eu", "emos", "estes", "eram"]
    let perfeitoIr = ["i", "iste", "iu", "imos", "istes", "iram"]
    let perfeitoAir = ["í", "íste", "iu", "ímos", "ístes", "íram"]
    let perfeitoSer = ["fui", "foste", "foi", "fomos", "fostes", "foram"]
    let perfeitoEstar = ["estive", "estiveste", "esteve", "estivemos", "estivestes", "estiveram"]
    let perfeitoVir = ["vim", "vieste", "veio", "viemos", "viestes", "vieram"]
    let perfeitoTer = ["tive", "tiveste", "teve", "tivemos", "tivestes", "tiveram"]
    let perfeitoFazer = ["fiz", "fizeste", "fez", "fizemos", "fizestes", "fizeram"]
    let perfeitoDizer = ["sse", "sseste", "sse", "ssemos", "ssestes", "sseram"]
    let perfeitoTrazer = ["trouxe", "trouxeste", "trouxe", "trouxemos", "trouxestes", "trouxeram"]
    let perfeitoSaber = ["soube", "soubeste", "soube", "soubemos", "soubestes", "souberam"]
    let perfeitoPoder = ["pude", "pudeste", "pôde", "pudemos", "pudestes", "puderam"]
    let perfeitoQuerer = ["quis", "quiseste", "quis", "quisemos", "quisestes", "quiseram"]
    let perfeitoPor = ["pus", "puseste", "pôs", "pusemos", "pusestes", "puseram"]
    
    // Pretérito Pretérito Imperfeito Indicativo
    let imperfeitoAr = ["ava", "avas", "ava", "ávamos", "aveis", "avam"]
    let imperfeitoEr = ["ia", "ias", "ia", "íamos", "íeis", "iam"]
    let imperfeitoIr = ["ia", "ias", "ia", "íamos", "íeis", "iam"]
    let imperfeitoAir = ["ía", "ías", "ía", "íamos", "íeis", "íam"]

    let imperfeitoSer = ["era", "eras", "era", "éramos", "éreis", "eram"]
    let imperfeitoVir = ["vinha", "vinhas", "vinha", "vínhamos", "vínheis", "vinham"]
    let imperfeitoTer = ["tinha", "tinhas", "tinha", "tínhamos", "tínheis", "tinham"]
    let imperfeitoPor = ["punha", "punhas", "punha", "púnhamos", "púnheis", "punham"]
    
    // Pretérito Mais-que-perfeito Indicativo
    let pmqp = ["a", "as", "a", "---", "---", "am"]
    let pmqpAr = ["---", "---", "---", "áramos", "áreis", "---"]
    let pmqpEr = ["---", "---", "---", "êramos", "êreis", "---"]
    let pmqpIr = ["---", "---", "---", "íramos", "íreis", "---"]
    // irregulares ending on -er like vir, fazer, ter, estiver, trazer, saber, poder, querer, pôr, dizer
    let pmqpEr2 = ["---", "---", "---", "iéramos", "iéreis", ""]
    let pmqpSer = ["---", "---", "---", "ôramos", "ôreis", "---"]
    
    // Futuro Simples Indicativo
    // regulares
    let futuroSimples = ["ei", "ás", "á", "emos", "eis", "ão"]
    // irregulares: fazer, dizer, trazer, por
    let futuroSimplesFazer = ["rei", "rás", "rá", "remos", "reis", "rão"]
    let futuroSimplesPor = ["porei", "porás", "porá", "poremos", "poreis", "porão"]
    
    // Subjuntivo
    // Presente Subjuntivo
    let presenteSubAr = ["e", "es", "e", "emos", "eis", "em"]
    // er & ir, sentir, vir, ver, ter, dizer, poder, perder, por, -oir
    let presenteSubErIr = ["a", "as", "a", "amos", "ais", "am"]
    let presenteSubEar = ["ie", "ies" , "ie", "emos", "eis", "iem"]
    // ser e estar
    let presenteSubIs = ["eja", "ejas", "eja", "ejamos", "ejaisa", "ejam"]
    // special cases
    let presenteSubIra = ["vá", "vás", "vá", "vamos", "vades", "vão"]
    
    // Pretérito Pretérito Imperfeito Subjuntivo
    let imperfeitoSub = ["sse", "sses", "sse", "---", "---", "ssem"]
    let imperfeitoSubAr = ["---", "---", "---", "ássemos", "ásseis", "---"]
    let imperfeitoSubEr = ["---", "---", "---", "êssemos", "êsseis", "---"]
    // irregulares ending on -er like vir, fazer, ter, estiver, trazer, saber, poder, querer, pôr, dizer
    let imperfeitoSubEr2 = ["---", "---", "---", "éssemos", "ésseis", "---"]
    let imperfeitoSubIr = ["---", "---", "---", "íssemos", "ísseis", "---"]
    let imperfeitoSubSer = ["---", "---", "---", "ôssemos", "ôsseis", "---"]

    // Futuro Subjuntivo
    let futuroSub = ["", "es", "", "mos", "des", "em"]
    let futuroSubAir = ["ir", "íres", "ir", "irmos", "irdes", "írem"]
    
    // Condicional
    // Condicional I  Pretérito Simples
    let condicionalI = ["ia", "ias", "ia", "íamos", "íeis", "iam"]
    let condicionalIIrr = ["ria", "rias", "ria", "ríamos", "ríeis", "riam"]
    let condicionalIPor = ["poria", "poria", "poria", "poríamos", "poríeis", "poriam"]
    
    // Participio
    let participioAr = "ado"
    let participioEr = "ido"
    let participioIr = "ido"
    let participioAir = "ído"
    let participioVir = "indo"
    let participioVer = "visto"
    let participioFazer = "feito"
    let participioDizer = "dito"
    let participioPor = "posto"
    let participioAbrir = "aberto"
    
    // correct numberInArray for Array-enumeration (beginning with 0)
    if numero == "singular" {
        nummerInArray = pessoa - 1
    } else {
        nummerInArray = pessoa + 2
    }
    
    // Test cases across Tenses
    if caso == "Presente Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar") {
            if (verbo[0].suffix(3) == "ear") {
                ziel = stamm + presenteEar[nummerInArray]
            } else {
                ziel = stamm + presenteAr[nummerInArray]
            }
        } else if (
            verbo[1] == "er" || verbo[1] == "saber" || verbo[1] == "poder"
            || verbo[1] == "perder" || verbo[1] == "dizer" || verbo[1] == "querer"
            || verbo[1] == "fazer" || verbo[1] == "trazer"
        ) {
            if (nummerInArray == 0 && (String(verbo[0].suffix(3)) == "cer")) {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + presenteCer[nummerInArray]
            } else if (nummerInArray == 0 && verbo[0] == "saber") {
                ziel = presenteSaber[nummerInArray]
            } else if (nummerInArray == 0 && verbo[0] == "poder") {
                ziel = presentePoder[nummerInArray]
            } else if (nummerInArray == 0 && verbo[0] == "perder") {
                ziel = presentePerder[nummerInArray]
            } else if (nummerInArray == 2 && verbo[0] == "querer") {
                ziel = presenteQuerer[nummerInArray]
            } else if ((nummerInArray == 0 || nummerInArray == 2)  && verbo[0] == "dizer") {
                ziel = presenteDizer[nummerInArray]
            } else if ((nummerInArray == 0 || nummerInArray == 2) && verbo[0] == "fazer") {
                ziel = presenteFazer[nummerInArray]
            } else if ((nummerInArray == 0 || nummerInArray == 2) && verbo[0] == "trazer") {
                ziel = presenteTrazer[nummerInArray]
            } else if (verbo[0] == "ler") {
                ziel = presenteLer[nummerInArray]
            } else {
                ziel = stamm + presenteEr[nummerInArray]
            }
        } else if (verbo[1] == "ir") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + presenteAir[nummerInArray]
            }
            else if (nummerInArray == 0 && verbo[0] == "dormir") {
               ziel = presenteDormir[nummerInArray]
            } else if (nummerInArray == 0 && (verbo[0] == "mentir" || verbo[0] == "sentir")) {
                stamm = String(verbo[0].dropLast(5))
                ziel = stamm + presenteEntir[nummerInArray]
            } else if (nummerInArray == 0 && verbo[0] == "servir") {
                stamm = String(verbo[0].dropLast(5))
                ziel = stamm + presenteErvir[nummerInArray]
            } else {
                ziel = stamm + presenteIr[nummerInArray]
            }
        } else if (verbo[1] == "ira") {
            ziel = presenteIra[nummerInArray]
        } else if (verbo[1] == "ser") {
            ziel = presenteSer[nummerInArray]
        } else if (verbo[1] == "estar") {
            ziel = presenteEstar[nummerInArray]
        } else if (verbo[1] == "vir") {
            ziel = presenteVir[nummerInArray]
        } else if (verbo[1] == "ver") {
            ziel = presenteVer[nummerInArray]
        } else if (verbo[1] == "ter") {
            ziel = presenteTer[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = presentePor[nummerInArray]
        }
    } else if caso == "Pretérito Perfeito Simples Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar") {
            ziel = stamm + perfeitoAr[nummerInArray]
        } else if (verbo[1] == "er" ) {
            if (verbo[0] == "dizer") {
                stamm = String(verbo[0].dropLast(3))
                ziel = stamm + perfeitoDizer[nummerInArray]
            } else {
                ziel = stamm + perfeitoEr[nummerInArray]
            }
        } else if (verbo[1] == "ir" || verbo[1] == "ver") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = stamm + perfeitoAir[nummerInArray]
            } else {
                ziel = stamm + perfeitoIr[nummerInArray]
            }
        } else if (verbo[1] == "ser" || verbo[1] == "ira") {
            ziel = perfeitoSer[nummerInArray]
        } else if (verbo[1] == "estar") {
            ziel = perfeitoEstar[nummerInArray]
        } else if (verbo[1] == "vir") {
            ziel = perfeitoVir[nummerInArray]
        } else if (verbo[1] == "ter") {
            ziel = perfeitoTer[nummerInArray]
        } else if (verbo[1] == "fazer") {
            ziel = perfeitoFazer[nummerInArray]
        } else if (verbo[1] == "trazer") {
            ziel = perfeitoTrazer[nummerInArray]
        } else if (verbo[1] == "saber") {
            ziel = perfeitoSaber[nummerInArray]
        } else if (verbo[1] == "poder") {
            ziel = perfeitoPoder[nummerInArray]
        } else if (verbo[1] == "querer") {
            ziel = perfeitoQuerer[nummerInArray]
        } else if verbo[1] == "por" {
            ziel = perfeitoPor[nummerInArray]
        }
    } else if caso == "Pretérito Imperfeito Indicativo" {
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = stamm + imperfeitoAr[nummerInArray]
        } else if (verbo[1] == "er" || verbo[1] == "ver"  || verbo[1] == "fazer" || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "querer") {
            ziel = stamm + imperfeitoEr[nummerInArray]
        } else if (verbo[1] == "ir" || verbo[1] == "ira") {
            if (String(verbo[0].suffix(3)) == "air") {
                ziel = stamm + imperfeitoAir[nummerInArray]
            } else {
                ziel = stamm + imperfeitoIr[nummerInArray]
            }
        } else if (verbo[1] == "ser") {
            ziel = imperfeitoSer[nummerInArray]
        } else if (verbo[1] == "vir") {
            ziel = imperfeitoVir[nummerInArray]
        } else if (verbo[1] == "ter") {
            ziel = imperfeitoTer[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = imperfeitoPor[nummerInArray]
        }
    } else if caso == "Pretérito Perfeito Composto Indicativo" {
        hilfsverb  = ppcHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "querer") {
            if (verbo[0] == "dizer") {
                ziel = hilfsverb + " " + participioDizer
            } else {
                ziel = hilfsverb + " " + stamm + participioEr
            }
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Mais-que-Perfeito Composto Indicativo" {
        hilfsverb  = pmqpHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder" || verbo[1] == "querer") {
            if (verbo[0] == "dizer") {
                ziel = hilfsverb + " " + participioDizer
            } else {
                ziel = hilfsverb + " " + stamm + participioEr
            }
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Mais-que-Perfeito Indicativo" {
        if (nummerInArray == 3 || nummerInArray == 4) {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 4)
            if (
                verbo[1] == "estar" || verbo[1] == "vir" || verbo[1] == "ter" || verbo[1] == "fazer"
                || verbo[0] == "dizer" || verbo[1] == "trazer" || verbo[1] == "saber"
                || verbo[1] == "poder" || verbo[1] == "querer" || verbo[1] == "por"
            ) {
                // case éssemos
                ziel = hilfsverbPerfeito + pmqpEr2[nummerInArray]
            } else if (verbo[1] == "ar") {
                // case ássemos
                ziel = hilfsverbPerfeito + pmqpAr[nummerInArray]
            } else if (verbo[1] == "er" ) {
                // case êssemos
                ziel = hilfsverbPerfeito + pmqpEr[nummerInArray]
                
            } else if (verbo[1] == "ir" || verbo[1] == "ver") {
                // case íssemos
                ziel = hilfsverbPerfeito + pmqpIr[nummerInArray]
            } else if (verbo[1] == "ser" || verbo[1] == "ira") {
                // case óssemos
                ziel = hilfsverbPerfeito + pmqpSer[nummerInArray]
            }
        } else {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 2)
            ziel = hilfsverbPerfeito + pmqp[nummerInArray]
        }
    } else if caso == "Futuro Simples Indicativo" {
        if (verbo[1] == "fazer" || verbo[1] == "trazer" || verbo[0] == "dizer") {
            stamm = String(verbo[0].dropLast(3))
            ziel = stamm + futuroSimplesFazer[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = futuroSimplesPor[nummerInArray]
        } else {
            stamm = String(verbo[0])
            ziel = stamm + futuroSimples[nummerInArray
            ]
        }
    } else if caso == "Futuro Composto Indicativo" {
        hilfsverb  = futcomHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" ||  verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder" || verbo[1] == "querer") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Presente Subjuntivo" {
        stamm = buildPresenteHelper(entrada: verbo, cair: 1)
        if (verbo[1] == "ar") {
            if (verbo[0] == "pagar") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 1)
                ziel = stamm + "u" + presenteSubAr[nummerInArray]
            } else if (verbo[0] == "significar") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 2)
                ziel = stamm  + "qu" + presenteSubAr[nummerInArray]
            } else {
                ziel = stamm + presenteSubAr[nummerInArray]
            }
        } else if (
            verbo[1] == "er" || verbo[1] == "ir" || verbo[0] == "dizer" || verbo[1] == "por"
            || verbo[1] == "vir" || verbo[1] == "ver" || verbo[1] == "ter" || verbo[1] == "poder"
            || verbo[1] == "saber" || verbo[1] == "querer" || verbo[1] == "fazer" || verbo[1] == "trazer"
        ) {
            if (verbo[1] == "saber") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 2)
                ziel = stamm  + "aib" + presenteSubErIr[nummerInArray]
            } else if (verbo[1] == "querer") {
                stamm = buildPresenteHelper(entrada: verbo, cair: 2)
                ziel = stamm + "ir" + presenteSubErIr[nummerInArray]
            } else {
                ziel = stamm + presenteSubErIr[nummerInArray]
            }
        } else if (String(verbo[0].suffix(3)) == "ear") {
            ziel = stamm + presenteSubEar[nummerInArray]
        } else if (verbo[1] == "ser" || verbo[1] == "estar") {
            stamm = buildPresenteHelper(entrada: verbo, cair: 2)
            ziel = stamm + presenteSubIs[nummerInArray]
        } else if (verbo[1] == "ira") {
            ziel = presenteSubIra[nummerInArray]
        }
    } else if caso == "Pretérito Perfeito Simples Subjuntivo" {
        hilfsverb  = perfeitoSubHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder" || verbo[1] == "querer") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + stamm + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Pretérito Imperfeito Subjuntivo" {
        if (nummerInArray == 3 || nummerInArray == 4) {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 4)
            if (verbo[1] == "ar") {
                // case ássemos
                ziel = hilfsverbPerfeito + imperfeitoSubAr[nummerInArray]
            } else if (verbo[1] == "er" ) {
                // case êssemos
                ziel = hilfsverbPerfeito + imperfeitoSubEr[nummerInArray]
                
            } else if (verbo[1] == "ir" || verbo[1] == "ver") {
                // case íssemos
                ziel = hilfsverbPerfeito + imperfeitoSubIr[nummerInArray]
            } else if (verbo[1] == "ser" || verbo[1] == "ira") {
                // case óssemos
                ziel = hilfsverbPerfeito + imperfeitoSubSer[nummerInArray]
            }  else if (
                verbo[1] == "estar" || verbo[1] == "vir" || verbo[1] == "ter" || verbo[1] == "fazer"
                || verbo[0] == "dizer" || verbo[1] == "trazer" || verbo[1] == "saber"
                || verbo[1] == "poder" || verbo[1] == "querer" || verbo[1] == "por"
            ) {
                // case éssemos
                ziel = hilfsverbPerfeito + imperfeitoSubEr2[nummerInArray]
            }
        } else {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 3)
            ziel = hilfsverbPerfeito + imperfeitoSub[nummerInArray]
        }
    } else if caso == "Pretérito Mais-que-Perfeito Subjuntivo"{
        hilfsverb  = pmqpCompSubHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if verbo[0] == "dizer" {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"
                   || verbo[1] == "querer" || verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Futuro Simples Subjuntivo" {
        if (String(verbo[0].suffix(3)) == "air") {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 4)
            ziel = hilfsverbPerfeito + futuroSubAir[nummerInArray]
        } else {
            hilfsverbPerfeito = buildPerfeitoHelper(entrada: verbo, cair: 2)
            ziel = hilfsverbPerfeito + futuroSub[nummerInArray]
        }
    } else if caso == "Futuro Composto Subjuntivo" {
        hilfsverb  = futuroCompSubHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (
            verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"
            || verbo[1] == "querer" || verbo[1] == "ser"
        ) {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if verbo[1] == "por" {
            ziel = hilfsverb + " " + participioPor
        }
    } else if caso == "Futuro do Préterito (Condicional I)" {
        if (verbo[0] == "dizer" || verbo[0] == "trazer" || verbo[0] == "fazer") {
            stamm = String(verbo[0].dropLast(3))
            ziel = stamm + condicionalIIrr[nummerInArray]
        } else if (verbo[1] == "por") {
            ziel = condicionalIPor[nummerInArray]
        } else {
            stamm = String(verbo[0])
            ziel = stamm + condicionalI[nummerInArray]
        }
    } else if caso == "Futuro do Préterito Composto (Condicional II)"{
        hilfsverb  = condIIHv[nummerInArray]
        stamm = String(verbo[0].dropLast(2))
        if (verbo[0] == "dizer") {
            ziel = hilfsverb + " " + participioDizer
        } else if (verbo[1] == "ar" || verbo[1] == "estar") {
            ziel = hilfsverb + " " + stamm + participioAr
        } else if (verbo[1] == "er"  || verbo[1] == "trazer" || verbo[1] == "saber" || verbo[1] == "poder"  || verbo[1] == "querer") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[0] == "abrir") {
            ziel = hilfsverb + " " + participioAbrir
        } else if (verbo[1] == "ir" || verbo[1] == "ira" || verbo[1] == "ter") {
            if (String(verbo[0].suffix(3)) == "air") {
                stamm = String(verbo[0].dropLast(2))
                ziel = hilfsverb + " " + stamm + participioAir
            } else {
                ziel = hilfsverb + " " + stamm + participioIr
            }
        } else if (verbo[1] == "ser") {
            ziel = hilfsverb + " " + stamm + participioEr
        } else if (verbo[1] == "vir") {
            ziel = hilfsverb + " " + stamm + participioVir
        } else if (verbo[1] == "ver") {
            ziel = hilfsverb + " " + participioVer
        } else if (verbo[1] == "fazer") {
            ziel = hilfsverb + " " + participioFazer
        } else if (verbo[1] == "por") {
            ziel = hilfsverb + " " + participioPor
        }
    }

    stamm = "";
    hilfsverb = "";
    nummerInArray = 0;
    
    return(ziel)
}

/// creates verb stem for the conjugation of Pretérito Perfeito Simples Indicativo
///
/// This function is needed since in Pretérito Perfeito Simples Indicativo some verbs loose more than the two last characters of the verb. It takes the verb array as input as well as the number of characters to loose. It returns the correct verb stem that is then used to build the conjugation ``target``.
/// - Parameters:
///   - entrada: verb array to conjugate (`Array<String>`)
///   - cair: number of characters to cut from the verb stem (`Int`)
/// - Returns: the correct verb stem for the conjugation in Pretérito Perfeito Simples Indicativo.
func buildPerfeitoHelper(entrada: Array<String>, cair: Int) -> String {
    var helfer: String = ""
    helfer = trainTarget(pessoa: 3, numero: "plural", caso: "Pretérito Perfeito Simples Indicativo", verbo: entrada)
    helfer = String(helfer.dropLast(cair))
    return(helfer)
}

/// creates verb stem for the conjugation of Presente subjuntivo
///
/// This function is needed since in Presente Subjuntivo some verbs loose more than the two last characters of the verb. It takes the verb array as input as well as the number of characters to loose. It returns the correct verb stem that is then used to build the conjugation ``target``.
/// - Parameters:
///   - entrada: verb array to conjugate (`Array<String>`)
///   - cair: number of characters to cut from the verb stem (`Int`)
/// - Returns: the correct verb stem for the conjugation in Presente subjuntivo.
func buildPresenteHelper(entrada: Array<String>, cair: Int) -> String {
    var helfer: String = ""
    helfer = trainTarget(pessoa: 1, numero: "singular", caso: "Presente Indicativo", verbo: entrada)
    helfer = String(helfer.dropLast(cair))
    return(helfer)
}

/// creates an alert message of the result
///
/// This function creates a message presenting the result of the comparison of the user's input and the conjugation ``target``. If the user is incorrect, it also shows the correct version of the conjugation.
/// - Parameters:
///   - resultado: result of the comparison of input and correct conjugation (`Bool`)
///   - alvo: correct conjugation (`String`)
/// - Returns: <#description#>
func createAlertMessage(resultado: Bool, alvo: String) -> String {
    var alarmNachricht: String = ""
    if resultado == true {
        alarmNachricht = "✅ Arrasou! A sua dica foi correta. 🚀"
    } else {
        alarmNachricht = "🙅🏽‍♂️ Esta vez não! ❌ \n" + "\n A forma correta é: " + alvo
    }
    return(alarmNachricht)
}

/// checks the user input against the ``target``.
///
///  This function just checks the input of the user against the ``target`` of the conjugation. It returns `true` if the input is correct, otherwise `false`.
/// - Parameters:
///   - entrada: input of the user (`String`)
///   - alvo: input of the correct conjugation (`String`)
/// - Returns: result of comparison of `entrada` and `alvo` (`Bool`)
func proof(entrada: String, alvo: String) -> Bool {
    let ergebnis: Bool
    if entrada == alvo {
        ergebnis = true
    } else {
        ergebnis = false
    }

    return(ergebnis)
}

#Preview {
    trainView()
}

