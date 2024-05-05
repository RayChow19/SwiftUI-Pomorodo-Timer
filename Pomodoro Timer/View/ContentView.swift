//
//  ContentView.swift
//  Pomodoro Timer
//
//  Created by Ray Chow on 18/4/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { item in
                    NavigationLink {
                        PomodoroTimerView(item: item)
                    } label: {
                        Text(item.name)
                    }
                }
                .onDelete(perform: deleteItems)
            }
#if os(macOS)
            .navigationSplitViewColumnWidth(min: 180, ideal: 200)
#endif
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton {
                        
                    }
                }
#endif
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
        .task {
            if items.isEmpty {
                addFirstItem()
            }
        }
        
    }
    
    private func addFirstItem() {
        withAnimation {
            let newItem = Item(nameSuffix:getNextSuffix(), displayOrder: items.count, notes: "notes")
            modelContext.insert(newItem)
        }
    }

    private func addItem() {
        withAnimation {
            let newItem = Item(nameSuffix:getNextSuffix(), displayOrder: items.count)
            modelContext.insert(newItem)
        }
    }

    private func getNextSuffix() -> Int {
        let timerSuffixes = items.compactMap { item in
            if item.name.hasPrefix("Timer"), let number = Int(item.name.dropFirst(5)) {
                return number
            } else {
                return nil
            }
        }
        
        for i in 1... {
            if !timerSuffixes.contains(i) {
                return i
            }
        }
        
        return 1
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
