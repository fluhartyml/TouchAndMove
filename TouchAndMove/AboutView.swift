//
//  AboutView.swift
//  TouchAndMove
//

import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    Image("AppIcon-About")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 140, height: 140)
                        .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                        .shadow(radius: 8)
                        .padding(.top, 12)
                        .accessibilityHidden(true)

                    Text("Touch & Move")
                        .font(.largeTitle)
                        .fontWeight(.semibold)

                    Text("A SwiftUI gesture playground")
                        .font(.title3)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Text("Build-Along 09 of Claude's X26 Swift 6 Bible")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)

                    Divider().padding(.horizontal)

                    VStack(alignment: .leading, spacing: 12) {
                        Text("Made by Michael Fluharty, written with Claude.")
                            .font(.body)
                        Text("Distributed as GitHub clone-and-build. Source, wiki, and chapter live in the book.")
                            .font(.body)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.horizontal)

                    Divider().padding(.horizontal)

                    VStack(alignment: .leading, spacing: 10) {
                        Link("fluharty.me", destination: URL(string: "https://fluharty.me")!)
                        Link("Send Feedback", destination: URL(string: "mailto:michael.fluharty@mac.com?subject=TouchAndMove%20Feedback")!)
                        Link("Privacy", destination: URL(string: "https://fluharty.me/privacy")!)
                    }
                    .font(.body)
                    .padding(.horizontal)

                    Spacer(minLength: 16)
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("About")
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
    AboutView()
}
