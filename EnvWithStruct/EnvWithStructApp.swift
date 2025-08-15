//
//  EnvWithStructApp.swift
//  EnvWithStruct
//
//  Created by me developer on 14/08/2025.
//

import SwiftUI



import SwiftUI


@main
struct EnvWithStructApp: App {
    var body: some Scene {
        WindowGroup {
            // We use the wrapper view here to set the environment.
            // All the content inside will inherit these values.
            EnvironmentWrapperView {
                ContentView()
            }
        }
    }
}
