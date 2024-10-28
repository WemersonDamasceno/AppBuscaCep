//
//  HiddenView.swift
//  AppBuscaCep
//
//  Created by Wemerson Damasceno on 28/10/24.
//

import SwiftUI

extension View {
    func isHidden(_ hidden: Bool) -> some View {
        self.modifier(HiddenModifier(hidden: hidden))
    }
}

struct HiddenModifier: ViewModifier {
    var hidden: Bool
    
    func body(content: Content) -> some View {
        Group {
            if hidden {
                content.hidden() // Esconde a View
            } else {
                content // Mostra a View
            }
        }
    }
}

