//
//  UnderTheHoodView.swift
//  TouchAndMove
//

import SwiftUI

struct UnderTheHoodView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            List(DeveloperNotes.notes) { note in
                Section(note.title) {
                    Text(note.body)
                        .font(.body)
                        .foregroundStyle(.primary)
                }
            }
            .navigationTitle("Under the Hood")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Done") { dismiss() }
                }
            }
        }
    }
}

#Preview {
    UnderTheHoodView()
}
