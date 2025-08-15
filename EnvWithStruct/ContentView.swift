//
//  ContentView.swift
//  EnvWithStruct
//
//  Created by me developer on 14/08/2025.
//

import SwiftUI


// All other structs and extensions remain the same.
struct MyData {
    var name: String
    var age: Int
    
    func md1() -> String {
        "in func \(name)-\(age)"
    }
}

struct YourData {
    var name: String
    var age: Int
}
struct ContentView: View {
    @Environment(\.myData) var data: MyData
    @Environment(\.yourData) var yourData: YourData
    
    var body: some View {
        VStack(spacing: 15) {
            Text("Hello from ContentView, \(data.name)! You are \(data.age) years old.")
            Text("Hello from ContentView, \(yourData.name)! You are \(yourData.age) years old.")
            Text(MyData(name: "albert", age: 99).md1())
            MyView()
        }
    }
}

private struct MyDataKey: EnvironmentKey {
    static var defaultValue: MyData = MyData(name: "Guest", age: 0)
}

private struct YourDataKey: EnvironmentKey {
    static var defaultValue: YourData = YourData(name: "Guest", age: 0)
}
extension EnvironmentValues {
    var myData: MyData {
        get { self[MyDataKey.self] }
        set { self[MyDataKey.self] = newValue }
    }
        
    var yourData: YourData {
            get { self[YourDataKey.self] }
            set { self[YourDataKey.self] = newValue }
        }
    }

struct MyView: View {
    @Environment(\.myData) var data: MyData
    @Environment(\.yourData) var yourData: YourData
    
    var body: some View {
        Text("Hello from MyView, \(data.name)! You are \(data.age) years old.")
        Text("Hello from MyView, \(yourData.name)! You are \(yourData.age) years old.")
        Text(MyData(name: "albert", age: 99).md1())
    }
}

#Preview {
    ContentView()
        .environment(\.myData, MyData(name: "Alice", age: 30))
        .environment(\.yourData, YourData(name: "Bob", age: 35))
}

// Our generic wrapper view that sets the environment for its content.
struct EnvironmentWrapperView<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .environment(\.myData, MyData(name: "Alice", age: 30))
            .environment(\.yourData, YourData(name: "Bob", age: 35))
    }
}
/*
 
 You've just experienced one of the most subtle and powerful concepts in SwiftUI: the view life cycle and how the environment is passed down. The fact that a view's properties are set on creation, but modifiers are applied to its descendants, is a frequent source of confusion. By identifying and solving that, you've taken a huge leap in understanding how SwiftUI's declarative paradigm really works.
 */
