//
//  ExampleView1.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/22/23.
//

// MARK: Basic button customication using ButtonStyle

import SwiftUI

struct EmptyStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
	}
}

struct ColoredButtonStyle: ButtonStyle {
	let color: Color
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding(.vertical)
			.padding(.horizontal, 50)
			.background(color)
			.clipShape(RoundedRectangle(cornerRadius: 10))
			.foregroundColor(.white)
			.overlay(
				Color.black
					.opacity(configuration.isPressed ? 0.3 : 0)
					.clipShape(RoundedRectangle(cornerRadius: 10))
			)
	}
}

struct StripedRectangleButtonStyle: ButtonStyle {
	var offColor = Color.blue
	var onColor = Color.green
	func color(for configuration: Configuration) -> Color {
		configuration.isPressed ? onColor : offColor
	}
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			Rectangle()
				.fill(color(for: configuration))
				.frame(width: 10)
			
			configuration.label
				.padding()
				.foregroundColor(color(for: configuration))
				.textCase(.uppercase)
				.font(Font.title.bold())
				.border(color(for: configuration), width: 4)
		}
		.fixedSize()
	}
}

struct PushButtonStyle: ButtonStyle {
	let lightGray = Color(white: 0.8)
	func makeBody(configuration: Configuration) -> some View {
		let startEdge: UnitPoint
		let endEdge: UnitPoint
		if configuration.isPressed {
			startEdge = UnitPoint.bottomTrailing
			endEdge = UnitPoint.topLeading
		} else {
			startEdge = UnitPoint.topLeading
			endEdge = UnitPoint.bottomTrailing
		}
		return configuration.label
			.foregroundColor(Color.black.opacity(configuration.isPressed ? 0.7 : 1))
			.font(.largeTitle)
			.padding(40)
			.background(
				LinearGradient(
					gradient: Gradient(colors: [lightGray, .white]),
					startPoint: startEdge,
					endPoint: endEdge
				)
			)
			.overlay(
				Circle()
					.stroke(
						LinearGradient(
							gradient: Gradient(colors: [Color.white, lightGray]),
							startPoint: startEdge,
							endPoint: endEdge),
						lineWidth: 16
					)
					.padding(2)
					.overlay(
						Circle()
							.stroke(
								configuration.isPressed ? Color.black : Color.gray,
								lineWidth: 4
							)
					)
			)
			.clipShape(Circle())
			.scaleEffect(configuration.isPressed ? 0.9 : 1)
			.shadow(
				color: Color.black.opacity(configuration.isPressed ? 0 : 0.2),
				radius: 10,
				x: 10,
				y: 10
			)
	}
}

extension Color {
	static let classicRed = Color(red: 0.65, green: 0, blue: 0.075)
	static let classicGren = Color(red: 0.1, green: 0.6, blue: 0.1)
	static let classicBlue = Color(red: 0, green: 0.2, blue: 0.7)
}

struct GlassButtonStyle: ButtonStyle {
	let color: Color
	func makeBody(configuration: Configuration) -> some View {
		ZStack {
			configuration.label
				.font(.largeTitle.bold())
				.foregroundColor(color)
				.offset(x: -1, y: -1)
			
			configuration.label
				.font(.largeTitle.bold())
				.foregroundColor(.white)
		}
		.frame(maxWidth: .infinity)
		.padding()
		.background(
			color
				.overlay(
					LinearGradient(gradient: Gradient(stops: [
						Gradient.Stop(color: Color.white.opacity(0.6), location: 0),
						Gradient.Stop(color: Color.white.opacity(0.15), location: 0.499),
						Gradient.Stop(color: Color.white.opacity(0), location: 0.5),
						Gradient.Stop(color: Color.white.opacity(0), location: 0.8),
						Gradient.Stop(color: Color.white.opacity(0.2), location: 1)
					]), startPoint: .top, endPoint: .bottom)
				)
				.overlay(
					RoundedRectangle(cornerRadius: 15)
						.strokeBorder(Color.white.opacity(0.4), lineWidth: 1)
				)
		)
		.clipShape(RoundedRectangle(cornerRadius: 15))
	}
}

struct ExampleView1: View {
    var body: some View {
		ZStack {
			VStack {
				// button 1 ColoredButtonStyle
				Button {
					print("Pressed")
				} label: {
					Text("Press Me")
				}
				.buttonStyle(ColoredButtonStyle(color: .blue))
				
				// button 2 StripedRectangle
				Button {
					print("Press and Hold")
				} label: {
					Text("Press and Hold")
				}
				.buttonStyle(StripedRectangleButtonStyle())
				
				// button 3 PushButton
				Button {
					print("Hey")
				} label: {
					Image(systemName: "star")
				}
				.buttonStyle(PushButtonStyle())
				
				// button 4 GlassButtonStyle
				Button {
					print("Classic!")
				} label: {
					HStack {
						Image(systemName: "phone.down.fill")
						Text("Slide to end call")
					}
				}
				.buttonStyle(GlassButtonStyle(color: .classicRed))
				.padding(.horizontal)
			}
		}
    }
}

struct ExampleView1_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView1()
    }
}
