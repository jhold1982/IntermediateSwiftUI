//
//  ExampleView8.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/27/23.
//

// MARK: Creating a custom property wrapper using DynamicProperty

// SimpleText

import SwiftUI

@propertyWrapper struct Document: DynamicProperty {
	@State private var value = ""
	private let url: URL
	var wrappedValue: String {
		get {
			value
		}
		nonmutating set {
			do {
				try newValue.write(to: url, atomically: true, encoding: .utf8)
				value = newValue
			} catch {
				print("Failed to write output.")
			}
		}
	}
	var projectedValue: Binding<String> {
		Binding(
			get: { wrappedValue },
			set: { wrappedValue = $0 }
		)
	}
	init(_ filename: String) {
		let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		url = paths[0].appendingPathComponent(filename)
		let initialText = (try? String(contentsOf: url)) ?? ""
		_value = State(wrappedValue: initialText)
	}
}

struct DynamicPropertyView: View {
	@Document("Test.txt") var document
	var body: some View {
		NavigationStack {
			VStack {
				Spacer()
				TextEditor(text: $document)
					.padding()
				
				Button("Change document") {
					document = String(Int.random(in: 1...1000))
				}
				.background(.blue)
				.foregroundColor(.white)
				.clipShape(Capsule())
				.buttonStyle(.borderedProminent)
				.frame(width: 200, height: 44)
			}
			.navigationTitle("SimpleText")
		}
	}
}

struct DynamicPropertyView_Previews: PreviewProvider {
    static var previews: some View {
		DynamicPropertyView()
    }
}
