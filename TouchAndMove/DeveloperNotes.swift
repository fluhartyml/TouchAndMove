//
//  DeveloperNotes.swift
//  TouchAndMove
//

import Foundation

enum DeveloperNotes {
    static let notes: [Note] = [
        Note(
            title: "Why TouchAndMove exists",
            body: """
            This app is a gesture-to-animation playground from Build-Along 09 of \
            Claude's X26 Swift 6 Bible. One on-screen shape, every primary SwiftUI \
            gesture wired up, every change driving an animation. It is the whole \
            chapter's source of truth — the playground readers clone, build, and \
            study.
            """
        ),
        Note(
            title: "One shape, two state lanes",
            body: """
            The shape's offset, scale, and rotation each live in two pieces of state: \
            a committed value (offset, scale, rotation) and a live in-flight value \
            (dragOffset, pinchScale, pinchRotation). While the gesture is active the \
            view reads the sum of both. On gesture end, the live value collapses into \
            the committed one inside withAnimation, which gives the spring-back \
            release readers can feel.
            """
        ),
        Note(
            title: "Composing gestures",
            body: """
            Drag, magnify, and rotate are merged with SimultaneousGesture so all three \
            run at once — pinch to zoom while dragging while twisting. Tap and \
            long-press hang off their own modifiers (.onTapGesture, \
            .onLongPressGesture) because they answer different questions: did the \
            user touch the shape at all, and did they hold it.
            """
        ),
        Note(
            title: "Spring physics, not linear curves",
            body: """
            Releases use .spring(response:dampingFraction:). Response is the time the \
            spring takes to settle; damping is how bouncy the settle feels. Lower \
            damping = more wobble. The values here are tuned for a quick, playful \
            response — readers can tweak them to feel the difference.
            """
        ),
        Note(
            title: "Distribution",
            body: """
            TouchAndMove ships as a GitHub clone-and-build project, not an App Store \
            release. App Review's Guideline 2.2 reads gesture playgrounds as demos \
            and rejects them. Readers get the repo URL from the book's appendix and \
            wiki, clone it into Xcode, and build it themselves. The reader becoming \
            the developer is exactly the teaching outcome.
            """
        )
    ]

    struct Note: Identifiable {
        let id: UUID = UUID()
        let title: String
        let body: String
    }
}
