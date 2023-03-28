//
//  CustomLabelView.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/27/23.
//

// MARK: Customizing Label using LabelStyle

import SwiftUI

struct VerticalLabelStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		VStack {
			configuration.icon
			configuration.title
		}
		.padding()
		.overlay(
			Capsule()
				.stroke(Color.accentColor, lineWidth: 2)
		)
	}
}

struct CircledLabelStyle: LabelStyle {
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.icon
				.padding()
				.background(Color.accentColor)
				.foregroundColor(.white)
				.clipShape(Circle())
			
			configuration.title
				.font(.largeTitle)
		}
	}
}

protocol HoveringLabelStyle: LabelStyle {
	init(hovering: Bool)
}

struct HoveringLabel<LabelStyle: HoveringLabelStyle, Title: View, Icon: View>: View {
	let style: LabelStyle.Type
	// closer that takes no parameters, returns a Title
	let title: () -> Title
	let icon: () -> Icon
	@State private var isHovered = false
	var body: some View {
		Label(title: title, icon: icon)
			.labelStyle(style.init(hovering: isHovered))
			.onHover { over in
				withAnimation(.easeInOut(duration: 0.5)) {
					isHovered = over
				}
			}
	}
}

struct VerticalRevealingLabelStyle: HoveringLabelStyle {
	let hovering: Bool
	func makeBody(configuration: Configuration) -> some View {
		VStack {
			configuration.icon
			configuration.title
				.opacity(hovering ? 1 : 0)
		}
		.contentShape(Circle())
	}
}

struct HighlightingLabelStyle: HoveringLabelStyle {
	let hovering: Bool
	func makeBody(configuration: Configuration) -> some View {
		HStack {
			configuration.icon
			configuration.title
		}
		.padding()
		.background(
			Capsule()
				.fill(Color.accentColor.opacity(hovering ? 0.2 : 0))
		)
		.contentShape(Capsule())
	}
}

struct CustomLabelView: View {
	var body: some View  {
		HoveringLabel(style: HighlightingLabelStyle.self) {
			Text("Home")
		} icon: {
			Image(systemName: "house")
		}
    }
}

struct CustomLabelView_Previews: PreviewProvider {
    static var previews: some View {
        CustomLabelView()
    }
}
