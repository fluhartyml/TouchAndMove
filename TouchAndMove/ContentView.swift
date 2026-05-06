//
//  ContentView.swift
//  TouchAndMove
//

import SwiftUI

struct ContentView: View {
    @State private var offset: CGSize = .zero
    @State private var dragOffset: CGSize = .zero
    @State private var scale: CGFloat = 1.0
    @State private var pinchScale: CGFloat = 1.0
    @State private var rotation: Angle = .zero
    @State private var pinchRotation: Angle = .zero
    @State private var isLongPressed: Bool = false
    @State private var tapCount: Int = 0
    @State private var showUnderTheHood: Bool = false
    @State private var showAbout: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                background
                shape
                    .offset(x: offset.width + dragOffset.width,
                            y: offset.height + dragOffset.height)
                    .scaleEffect(scale * pinchScale)
                    .rotationEffect(rotation + pinchRotation)
                    .gesture(combinedGesture)
                    .onTapGesture { handleTap() }
                    .onLongPressGesture(minimumDuration: 0.4) { handleLongPress() }
            }
            .navigationTitle("Touch & Move")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Reset") { reset() }
                }
                ToolbarItem(placement: .automatic) {
                    Menu {
                        Button("Under the Hood") { showUnderTheHood = true }
                        Button("About") { showAbout = true }
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            .safeAreaInset(edge: .bottom) { readout }
            .sheet(isPresented: $showUnderTheHood) { UnderTheHoodView() }
            .sheet(isPresented: $showAbout) { AboutView() }
        }
    }

    // MARK: - Subviews

    private var background: some View {
        LinearGradient(
            colors: [.black, Color(red: 0.05, green: 0.05, blue: 0.12)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }

    private var shape: some View {
        RoundedRectangle(cornerRadius: 28, style: .continuous)
            .fill(isLongPressed ? Color.orange : Color.blue)
            .frame(width: 180, height: 180)
            .shadow(color: .black.opacity(0.5), radius: 12, x: 0, y: 8)
            .overlay(alignment: .bottomTrailing) {
                Text("\(tapCount)")
                    .font(.title2)
                    .foregroundStyle(.white)
                    .padding(8)
            }
            .accessibilityLabel("Touch and Move shape")
    }

    private var readout: some View {
        VStack(spacing: 4) {
            Text("Drag · Pinch · Rotate · Tap · Long-press")
                .font(.caption)
                .foregroundStyle(.secondary)
            HStack(spacing: 16) {
                stat("Offset", "\(Int(offset.width)), \(Int(offset.height))")
                stat("Scale", String(format: "%.2f", scale))
                stat("Angle", String(format: "%.0f°", rotation.degrees))
                stat("Taps", "\(tapCount)")
            }
            .font(.caption.monospacedDigit())
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(.ultraThinMaterial)
    }

    private func stat(_ label: String, _ value: String) -> some View {
        VStack(spacing: 2) {
            Text(label).foregroundStyle(.secondary)
            Text(value).foregroundStyle(.primary)
        }
    }

    // MARK: - Gestures

    private var combinedGesture: some Gesture {
        let drag = DragGesture()
            .onChanged { dragOffset = $0.translation }
            .onEnded { value in
                withAnimation(.spring(response: 0.45, dampingFraction: 0.7)) {
                    offset.width += value.translation.width
                    offset.height += value.translation.height
                    dragOffset = .zero
                }
            }

        let magnify = MagnifyGesture()
            .onChanged { pinchScale = $0.magnification }
            .onEnded { value in
                withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                    scale = max(0.4, min(scale * value.magnification, 4.0))
                    pinchScale = 1.0
                }
            }

        let rotate = RotateGesture()
            .onChanged { pinchRotation = $0.rotation }
            .onEnded { value in
                withAnimation(.spring(response: 0.5, dampingFraction: 0.75)) {
                    rotation += value.rotation
                    pinchRotation = .zero
                }
            }

        return SimultaneousGesture(drag, SimultaneousGesture(magnify, rotate))
    }

    // MARK: - Actions

    private func handleTap() {
        tapCount += 1
        withAnimation(.spring(response: 0.25, dampingFraction: 0.5)) {
            scale *= 1.15
        }
        withAnimation(.spring(response: 0.45, dampingFraction: 0.6).delay(0.15)) {
            scale /= 1.15
        }
    }

    private func handleLongPress() {
        withAnimation(.easeInOut(duration: 0.25)) {
            isLongPressed.toggle()
        }
    }

    private func reset() {
        withAnimation(.spring(response: 0.55, dampingFraction: 0.7)) {
            offset = .zero
            dragOffset = .zero
            scale = 1.0
            pinchScale = 1.0
            rotation = .zero
            pinchRotation = .zero
            isLongPressed = false
            tapCount = 0
        }
    }
}

#Preview {
    ContentView()
}
