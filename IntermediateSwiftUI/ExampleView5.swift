//
//  ExampleView5.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/23/23.
//

// MARK: Animating buttons using ButtonStyle

import SwiftUI

protocol AnimatingButtonStyle: ButtonStyle {
	init(animation: Double)
}

struct PulsingButtonStyle: AnimatingButtonStyle {
	let animation: Double
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color.blue)
			.clipShape(Circle())
			.foregroundColor(.white)
			.padding(4)
			.overlay(
				Circle()
					.stroke(Color.blue, lineWidth: 2)
					.scaleEffect(CGFloat(1 + animation))
					.opacity(1 - animation)
			)
	}
}

struct SpinningArcButtonStyle: AnimatingButtonStyle {
	let animation: Double
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color.blue)
			.clipShape(Circle())
			.foregroundColor(.white)
			.padding(4)
			.overlay(
				Circle()
					.trim(from: 0, to: 0.5)
					.stroke(Color.blue, lineWidth: 4)
					.rotationEffect(.init(degrees: -animation * 360))
			)
			.padding(6)
			.overlay(
				Circle()
					.trim(from: 0, to: 0.5)
					.stroke(Color.blue, lineWidth: 4)
					.rotationEffect(.init(degrees: animation * 360))
			)
	}
}

struct AnimatedButton<ButtonStyle: AnimatingButtonStyle, Content: View>: View {
	let buttonStyle: ButtonStyle.Type
	let action: () -> Void
	let label: () -> Content
	var animationSpeed = 5.0
	@State private var animation = 0.0
	
	var body: some View {
		Button(action: action, label: label)
			.buttonStyle(buttonStyle.init(animation: animation))
			.onAppear {
				withAnimation(Animation.easeOut(duration:
					animationSpeed).repeatForever(autoreverses: false)) {
					animation = 1
				}
			}
	}
}

struct ExampleView5: View {
	
    var body: some View {
		VStack {
			Button {
				print("Pressed")
			} label: {
				Image(systemName: "star")
			}
			.buttonStyle(SpinningArcButtonStyle(animation: 5))
			
//			AnimatedButton(buttonStyle: SpinningArcButtonStyle.self, animationSpeed: 1) {
//				print("Pressed")
//			} label: {
//				Image(systemName: "star")
//			}
		}
    }
}

struct ExampleView5_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView5()
    }
}
