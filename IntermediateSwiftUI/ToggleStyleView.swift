//
//  ExampleView9.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/27/23.
//

// MARK: Customizing Toggle using ToggleStyle

import SwiftUI

struct CheckToggleStyle: ToggleStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.label
			Button {
				configuration.isOn.toggle()
			} label: {
				Image(systemName: configuration.isOn ? "checkmark.circle.fill" : "circle")
					.foregroundColor(configuration.isOn ? .accentColor : .secondary)
					.accessibility(label: Text(configuration.isOn ? "Checked" : "Unchecked"))
					.imageScale(.large)
			}
		}
	}
}

struct ExampleView9: View {
	@State private var showAdvanced = false
    var body: some View {
        Toggle("Show advanded options", isOn: $showAdvanced)
			.toggleStyle(CheckToggleStyle())
    }
}

struct ExampleView9_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView9()
    }
}
