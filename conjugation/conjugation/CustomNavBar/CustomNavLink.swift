//
// CustomNavLink.swift
// conjugate-portuguese
//
// Created by Philipp Kleer on 29. October 2024
// Licensed by CC-BY-NC-SA 4.0
//

import SwiftUI

/// creates a custom navigation link
///
/// The structure uses ``CustomNavBarContainerView`` and ``CustomNavView``.
struct CustomNavLink<Label: View, Destination: View>: View {
    
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    
    var body: some View {
        NavigationLink(
            destination:
                CustomNavBarContainerView(content: {
                    destination
                })
                .navigationBarBackButtonHidden(true)
            ,
            label: {
                label
            }
        )
    }
}

struct CustomNavLink_Previews: PreviewProvider{
    static var previews: some View{
        CustomNavView{
            CustomNavLink(
                destination: Text("Destination")) {
                    Text("Click me")
                }
        }
    }
}
