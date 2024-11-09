//
// mainView.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 29. October 2024
// Licensed by CC-BY-NC-SA 4.0
//

import SwiftUI

/// structure for the start view
///
/// The structure initializes the environment variables of ``userSettings`` from the class ``UserSettings`` and the start view of the app.
///
@available(iOS 16.6, *)

struct mainView: View {
    /// set of values for the user settings
    ///
    /// The variable includes:
    ///  - chosen tenses
    ///  - chosen person (include tu, or not include tu)
    ///  - chosen verb groups (regular, irregular, or both)
    ///
    ///  ```swift
    /// @State var userSettings = UserSettings()
    ///  ```
    
    @State var userSettings = UserSettings()
    
    var body: some View {
        CustomNavView {
            VStack(alignment: .center) {
                CustomNavLink(
                    destination: optionsView()
                ) {
                    Text("Escolha as conjugações ")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(Color("textcolor"))
                        .customNavigationTitle("Conjugador")
                        .customNavigationBackButtonHidden(true)
                        .customNavigationResetHidden(true)
                        .customNavigationOptionsHidden(true)
                    Image(systemName: "gear")
                        .scaleEffect(2.0)
                        .foregroundColor(Color("textcolor"))
                }.padding(.top, 40)
                
                Divider()
                    .frame(height: 3)
                    .frame(width: 350)
                    .overlay(.style)
                    .background(Color("background"))
                
                CustomNavLink(
                    destination: trainView()
                    
                ) {
                    HStack(spacing: 0) {
                        Text("Comece o treino!")
                            .fontWeight(.semibold)
                            .padding()
                            .font(.title)
                            .foregroundColor(Color("textcolor"))
                        Image(systemName: "restart")
                            .scaleEffect(2.0)
                            .rotationEffect(.degrees(180))
                            .foregroundColor(Color("textcolor"))
                    }
                    .padding(.all, 0.0)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("background"))
        }.environmentObject(userSettings)
    }
}

#Preview {
    mainView()
}
