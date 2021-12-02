//
//  ContentView.swift
//  Shared
//
//  Created by Teddy Lin on 2021/12/2.
//

import SwiftUI
import CoreData
import Flutter

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showingFlutter = false

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    var body: some View {
        VStack{
            Button("Welcome to Flutter") {
                showingFlutter = true
            }
        }.sheet(isPresented: $showingFlutter) {
            FlutterPage()
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct FlutterPage: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> some UIViewController {
        let flutterViewController = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        return flutterViewController
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
