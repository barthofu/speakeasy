//
//  SpeakEasyApp.swift
//  SpeakEasy
//
//  Created by Bastien Bombardella on 10/12/2024.
//

import SwiftUI

@main
struct SpeakEasyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [
                    LocationModel.self,
                    PhotoModel.self
                ])
        }
    }
}
