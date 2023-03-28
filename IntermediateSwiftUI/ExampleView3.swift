//
//  ExampleView3.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/23/23.
//

// MARK: Advanced button customization using ButtonStyle

// Age of Empires buttonStyle

import SwiftUI


extension ExampleView3 {
	public func foregroundMask<Content: View>(_ overlay: Content) -> some View {
		self
			.overlay(overlay)
			.mask(self)
	}
}

struct FantasyButtonStyle: ButtonStyle {
	var foregroundGradientStart = Color(red: 1, green: 0.85, blue: 0.85)
	var foregroundGradientEnd = Color(red: 1, green: 0.65, blue: 0.3)
	
	var backgroundGradientStart = Color(red: 0.33, green: 0.06, blue: 0.04)
	var backgroundGradientEnd = Color(red: 0.5, green: 0.1, blue: 0.1)
	
	var rimGradientStart = Color(red: 0.725, green: 0.55, blue: 0.3)
	var rimGradientEnd = Color(red: 0.2, green: 0.13, blue: 0.05)
	
	private var foregroundGradient: LinearGradient {
		LinearGradient(
			gradient: Gradient(colors: [foregroundGradientStart, foregroundGradientEnd]),
			startPoint: .top,
			endPoint: .bottom
		)
	}
	
	private var backgroundGradient: LinearGradient {
		LinearGradient(
			gradient: Gradient(stops: [
				.init(color: backgroundGradientStart, location: 0),
				.init(color: backgroundGradientEnd, location: 0.3),
				.init(color: backgroundGradientEnd, location: 0.7),
				.init(color: backgroundGradientStart, location: 1)
			]),
			startPoint: .leading,
			endPoint: .trailing
		)
	}
	
	private var rimGradient: LinearGradient {
		LinearGradient(
			gradient: Gradient(stops: [
				.init(color: rimGradientStart, location: 0),
				.init(color: rimGradientStart, location: 0.49),
				.init(color: rimGradientEnd, location: 0.51),
				.init(color: rimGradientEnd, location: 1)
			]),
			startPoint: UnitPoint(x: 0.47, y: 0),
			endPoint: UnitPoint(x: 0.53, y: 1)
		)
	}
	
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.frame(maxWidth: .infinity)
			.foregroundMask(foregroundGradient)
			.font(Font.system(.largeTitle, design: .serif).lowercaseSmallCaps())
			.textCase(.uppercase)
			.shadow(color: .black, radius: 5, x: 3, y: 3)
			.padding()
			.background(
				ZStack {
					backgroundGradient
					if configuration.isPressed {
						Color.black.opacity(0.3)
					}
				}
			)
			.overlay(
				Rectangle()
					.stroke(Color.black, lineWidth: 8)
					.blur(radius: 8)
					.mask(Rectangle())
			)
			.overlay(
				Rectangle()
					.strokeBorder(rimGradientStart, lineWidth: 1)
					.padding(0.9)
					.overlay(
						Rectangle()
							.strokeBorder(rimGradient, lineWidth: 2)
					)
			)
	}
}

struct ExampleView3: View {
    var body: some View {
		ZStack {
			VStack {
				Button {
					print("XP Gained: 3000")
				} label: {
					Text("Dragonborn")
				}
				.buttonStyle(FantasyButtonStyle())
				.frame(width: 300)
			}
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity)
		.background(Color(red: 0.45, green: 0.375, blue: 0.3))
    }
}

struct ExampleView3_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView3()
    }
}
