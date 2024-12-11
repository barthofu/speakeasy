//
//  GlassedButton.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 11/12/2024.
//

import SwiftUI

struct GlassedButton: View {
    
    var systemImageName: String
    var text: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 10) {
                Image(systemName: systemImageName)
                    .font(.system(size: 30))
                    .foregroundColor(Color("Gray").opacity(0.8))
                Text(LocalizedStringKey(text))
                    .font(.headline)
                    .foregroundColor(Color.secondary)
            }
            .frame(maxWidth: .infinity, minHeight: 90)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
        }
    }
}

struct GlassedButtonPreview: PreviewProvider {
    static var previews: some View {
        GlassedButton(
            systemImageName: "phone.fill",
            text: "Call",
            action: {}
        )
    }
}
