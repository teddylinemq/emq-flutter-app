//
//  iOSApp.swift
//  Shared
//
//  Created by Teddy Lin on 2021/12/2.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant

var flutterEngine = FlutterEngine(name: "my flutter engine")

@main
struct iOSApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
    init() {
        // Runs the default Dart entrypoint with a default Flutter route.
        flutterEngine.run();
        // Used to connect plugins (only if you have plugins with iOS platform code).
        GeneratedPluginRegistrant.register(with: flutterEngine);
    }
}
