//
//  ExampleView6.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/24/23.
//

// MARK: Creating completely custom buttons using PrimitiveButtonStyle

// Debug button with production button

import SwiftUI

struct DebugButtonStyle: PrimitiveButtonStyle {
	let location: String
	
	func makeBody(configuration: Configuration) -> some View {
		Button {
			print("Button was pressed on line \(location)")
			configuration.trigger()
		} label: {
			configuration.label
		}
		.buttonStyle(ExampleButtonStyle())
	}
	init(file: String = #file, line: Int = #line) {
		location = "\(line) in \(file)"
	}
}

#if DEBUG
typealias CustomButtonType = DebugButtonStyle
#else
typealias CustomButtonType = ExampleButtonStyle
#endif

struct ExampleButtonStyle: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color.blue)
			.foregroundColor(.white)
			.clipShape(Capsule())
			.opacity(configuration.isPressed ? 0.7 : 1)
	}
}

struct ExampleView6: View {
    var body: some View {
		VStack {
			Button {
				print("Pressed")
			} label: {
				Text("Press Me")
			}
			.buttonStyle(CustomButtonType())
		}
    }
}

struct ExampleView6_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView6()
    }
}
