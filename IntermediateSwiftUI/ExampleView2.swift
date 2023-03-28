//
//  ExampleView2.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/22/23.
//

// MARK: Advanced button customization using ButtonStyle

// Aqua button

import SwiftUI

extension View {
	public func foregroundMask<Content: View>(_ overlay: Content) -> some View {
		self
			.overlay(overlay)
			.mask(self)
	}
}

struct AquaButtonStyle: ButtonStyle {
	let blueHighlight = Color(red: 0.7, green: 1, blue: 1)
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.padding(.horizontal, 20)
			.background(
				ZStack {
					Color(red: 0.3, green: 0.6, blue: 1)
					
					Capsule()
						.inset(by: 8)
						.offset(y: 8)
						.fill(
							LinearGradient(
								gradient: Gradient(colors: [blueHighlight.opacity(0), blueHighlight]),
								startPoint: .top,
								endPoint: UnitPoint(x: 0.5, y: 0.8)
							)
						)
						.scaleEffect(y: 0.7, anchor: .bottom)
						.blur(radius: 10)
					
					Capsule()
						.inset(by: 4)
						.fill(
							LinearGradient(
								gradient: Gradient(colors: [Color.white, Color.white.opacity(0)]),
								startPoint: .top,
								endPoint: UnitPoint(x: 0.5, y: 0.8)
							)
						)
						.scaleEffect(x: 0.95, y: 0.7, anchor: .top)
					
					if configuration.isPressed {
						Color.blue.opacity(0.2)
					}
				}
			)
			.clipShape(Capsule())
			.overlay(
				Capsule()
					.strokeBorder(Color.black.opacity(0.25), lineWidth: 1)
			)
	}
}

struct ExampleView2: View {
    var body: some View {
		ZStack {
			VStack {
				Button {
					print("Pressed")
				} label: {
					Text("Aqua ")
						.foregroundColor(.black)
						.font(.title)
				}
				.buttonStyle(AquaButtonStyle())
			}
		}
    }
}

struct ExampleView2_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView2()
    }
}
