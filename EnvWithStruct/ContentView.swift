//
//  ContentView.swift
//  EnvWithStruct
//
//  Created by me developer on 14/08/2025.
//

import SwiftUI

struct MyData {
    var name: String
    var age: Int
}

struct ContentView: View {
    var body: some View {
        MyView()
            .environment(\.myData, MyData(name: "Alice", age: 30))
    }
}

// Custom EnvironmentKey to hold our data
private struct MyDataKey: EnvironmentKey {
    static var defaultValue: MyData = MyData(name: "Guest", age: 0)
}

extension EnvironmentValues {
    var myData: MyData {
        get { self[MyDataKey.self] }
        set { self[MyDataKey.self] = newValue }
    }
}

struct MyView: View {
    @Environment(\.myData) var data: MyData
    
    var body: some View {
        Text("Hello, \(data.name)! You are \(data.age) years old.")
    }
}

#Preview {
    ContentView()
}

/*
 1. MyData Struct: The Data We're Passing 📦
 Swift

 struct MyData {
     var name: String
     var age: Int
 }
 This is a simple value type that holds the data we want to share. Think of this as a blueprint for a small piece of information. In this case, it's a person's name and age. Because it's a struct and not a class, it's lightweight and SwiftUI can handle it very efficiently.

 2. ContentView: Setting Up the Environment 🗺️
 Swift

 struct ContentView: View {
     var body: some View {
         MyView()
             .environment(\.myData, MyData(name: "Alice", age: 30))
     }
 }
 ContentView is our top-level view. Here, we create an instance of our MyView and then use the .environment modifier on it. This is the injection point. We're telling SwiftUI, "For MyView and all of its child views, please make this specific MyData value available in the environment."

 The syntax \.myData is a key path that refers to a custom property we've created on EnvironmentValues. This is how SwiftUI knows where to store and retrieve our data.

 3. MyDataKey: The Key to the Environment 🔑
 Swift

 private struct MyDataKey: EnvironmentKey {
     static var defaultValue: MyData = MyData(name: "Guest", age: 0)
 }
 This is a crucial piece. SwiftUI's environment is like a dictionary or a hash map where you have a key and a value. To store our MyData struct, we first need to define a key. The EnvironmentKey protocol requires a static var defaultValue. This is the value that SwiftUI will provide if a view tries to access \.myData but no value has been explicitly set higher up in the view hierarchy. It's a safety net.

 4. EnvironmentValues Extension: Making Our Key Accessible 🧩
 Swift

 extension EnvironmentValues {
     var myData: MyData {
         get { self[MyDataKey.self] }
         set { self[MyDataKey.self] = newValue }
     }
 }
 This extension is what allows us to use the \.myData key path. We're extending the built-in EnvironmentValues struct to include a new computed property called myData.

 The get block uses our custom MyDataKey to retrieve the value from the environment.

 The set block lets us update the value in the environment, which is what the .environment modifier does behind the scenes.

 Without this extension, SwiftUI wouldn't understand what \.myData refers to.

 5. MyView: Accessing the Environment Data 📥
 Swift

 struct MyView: View {
     @Environment(\.myData) var data: MyData
     
     var body: some View {
         Text("Hello, \(data.name)! You are \(data.age) years old.")
     }
 }
 Finally, we have MyView, which is a child of ContentView. This view doesn't need a MyData initializer. Instead, it uses the @Environment property wrapper. This wrapper tells SwiftUI, "Go look in the environment for the value associated with the \.myData key path, and assign it to this data property."

 The view then uses the data property to display the name and age. If ContentView had not provided a MyData value, this view would use the defaultValue we defined in MyDataKey ("Guest," 0) and the text would say "Hello, Guest! You are 0 years old."

 This entire pattern is a clean and flexible way to share data across multiple views without cluttering your code with a lot of initializers.








 
 
 
 
 */
