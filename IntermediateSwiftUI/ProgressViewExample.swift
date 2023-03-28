//
//  ProgressViewExample.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/27/23.
//

// MARK: Customizing ProgressView using ProgressViewStyle

import SwiftUI

struct GaugeProgressView: ProgressViewStyle {
	
	var trimAmount = 0.7
	var strokeColor = Color.blue
	var strokeWidth = 25.0
	
	let formatter = NumberFormatter()
	
	var rotation: Angle {
		Angle(radians: .pi * (1 - trimAmount)) + Angle(radians: .pi / 2)
	}
	
	func makeBody(configuration: Configuration) -> some View {
		
		let fractionCompleted = configuration.fractionCompleted ?? 0
		
		formatter.numberStyle = .percent
		let percentage = formatter.string(from: fractionCompleted as NSNumber) ?? "0%"
		
		return ZStack {
			
			Circle()
				.rotation(rotation)
				.trim(from: 0, to: CGFloat(trimAmount))
				.stroke(strokeColor.opacity(0.4), style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
			
			Circle()
				.rotation(rotation)
				.trim(from: 0, to: CGFloat(trimAmount * fractionCompleted))
				.stroke(strokeColor, style: StrokeStyle(lineWidth: CGFloat(strokeWidth), lineCap: .round))
			
			Text(percentage)
				.font(.system(size: 50, weight: .bold, design: .rounded))
				.offset(y: -4)
		}
	}
}

struct ProgressViewExample: View {
	
	@State private var progress = 0.2
	
    var body: some View {
		ProgressView("Label", value: progress, total: 1.0)
			.progressViewStyle(GaugeProgressView())
			.frame(width: 300)
			.onTapGesture {
				if progress < 1 {
					withAnimation {
						progress += 0.2
					}
				}
			}
    }
}

struct ProgressViewExample_Previews: PreviewProvider {
    static var previews: some View {
        ProgressViewExample()
    }
}
