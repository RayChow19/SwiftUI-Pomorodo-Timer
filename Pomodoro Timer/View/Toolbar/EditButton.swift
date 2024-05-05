//
//  EditButton.swift
//  Pomodoro Timer
//
//  Created by Ray Chow on 19/4/2024.
//

import SwiftUI

struct EditButton: View {
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Label(
                title: { Text("Edit") },
                icon: { Image(systemName: "pencil") }
            )
            
        }
    }
}

#Preview {
    EditButton(action: {})
}
