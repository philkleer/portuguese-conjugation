//
// CustomNavBarView.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 29. October 2024
// Licensed by CC-BY-NC-SA 4.0
//
import SwiftUI

/// structure that creates the customized navigation bar
///
struct CustomNavBarView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userSettings: UserSettings
    
    let title: String
    let subtitle: String?
    let showBackButton: Bool
    let showOptionsButton: Bool
    let showResetButton: Bool
    
    var body: some View {
        // Case: Hide BackButton, Show Reset, Show Conugation (train site)
        if !showBackButton && showResetButton && showOptionsButton {
            HStack{
                reset
                
                Spacer()
                
                titleSec
                
                Spacer()
                
                options
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            .padding(.top, 5)
            .font(.headline)
            .background(
                Color.style.ignoresSafeArea(edges: .all)
            )
            .foregroundColor(.white)
        }  else if showBackButton && !showResetButton && !showOptionsButton {
          // Case: Show BackButton, Hide Reset, Hide COnjugation
            HStack{
                goBack
                
                Spacer()
                
                titleSec
                
                Spacer()
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            .padding(.top, 5)
            .font(.headline)
            .background(
                Color.style.ignoresSafeArea(edges: .all)
            )
            .foregroundColor(.white)
        } else if !showBackButton && !showResetButton && !showOptionsButton {
            // Case: Hide BackButton, Hide ResetButton, Hide OptionsButton
            HStack{
                Spacer()
                
                titleSec
                
                Spacer()
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .padding(.bottom, 15)
            .padding(.top, 5)
            .font(.headline)
            .background(
                Color.style.ignoresSafeArea(edges: .all)
            )
            .foregroundColor(.white)
        } else {
            VStack{
                
                titleSec
                
                HStack{
                    
                    
                    if showBackButton {
                        goBack
                        
                        Spacer()
                    }
                    
                    if showResetButton {
                        reset
                        
                        Spacer()
                    }
                    
                    
                    
                    if showOptionsButton {
                        options
                        
                    }
                    
                }
                .padding(.leading, 20)
                .padding(.trailing, 20)
                .padding(.bottom, 15)
                .padding(.top, 5)
                .font(.headline)
                .background(
                    Color.style.ignoresSafeArea(edges: .all)
                )
                .foregroundColor(.white)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            .font(.headline)
            .background(
                Color.style.ignoresSafeArea(edges: .all)
            )
        }
     }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView(title: "Conjugador", subtitle: "", showBackButton: false, showOptionsButton: false, showResetButton: false)
            Spacer()
        }
    }
}

extension CustomNavBarView {
    /// appearance of the reset button
    private var reset: some View {
        Button(action: {
            userSettings.correct = 0
            userSettings.wrong = 0
        }, label: {
            Image(systemName: "arrow.2.squarepath")
                .scaleEffect(1.5)
                .rotationEffect(.degrees(180))
                .foregroundColor(Color(.white))
        })
    }
    
    /// appearance of the options button
    private var options: some View {
        CustomNavLink(destination: optionsView()) {
            Image(systemName: "gear")
                .scaleEffect(1.5)
                .foregroundColor(Color(.white))
        }
    }
    
    /// appearance of the go back button
    private var goBack: some View {
        CustomNavLink(destination: trainView()) {
            Image(systemName: "chevron.left")
                .scaleEffect(1.5)
                .foregroundColor(Color(.white))
        }
    }
    
    /// appearance of the title section
    private var titleSec: some View {
        
        VStack(spacing: 4){
            Text(title)
                .font(.title)
                .fontWeight(.semibold)
        }
        .foregroundColor(Color(.white))
        
    }
}

