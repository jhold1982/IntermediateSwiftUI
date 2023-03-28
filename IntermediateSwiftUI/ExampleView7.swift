//
//  ExampleView7.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/24/23.
//

// MARK: Timeout button

import SwiftUI
import Combine

struct CancellableButtonStyle: PrimitiveButtonStyle {
	private struct CancellableButton: View {
		@State private var timerSubscription: Cancellable?
		@State private var timer = Timer.publish(
			every: 1,
			on: .main,
			in: .common
		)
		@State private var countDown = 0
		let configuration: Configuration
		let timeOut: Int
		var body: some View {
			Button {
				if timerSubscription == nil {
					timer = Timer.publish(
						every: 1,
						on: .main,
						in: .common
					)
					timerSubscription = timer.connect()
					countDown = timeOut
				} else {
					cancelTimer()
				}
			} label: {
				if timerSubscription == nil {
					configuration.label
				} else {
					Text("Cancel? ...\(countDown)")
				}
			}
			.padding()
			.background(Color.blue)
			.foregroundColor(.white)
			.clipShape(Capsule())
			.onReceive(timer) { _ in
				if countDown > 1 {
					countDown -= 1
				} else {
					configuration.trigger()
					cancelTimer()
				}
			}
		}
		func cancelTimer() {
			timerSubscription?.cancel()
			timerSubscription = nil
		}
	}
	var timeOut = 3
	func makeBody(configuration: Configuration) -> some View {
		CancellableButton(configuration: configuration, timeOut: timeOut)
	}
}

struct ExampleButtonStyle7: ButtonStyle {
	func makeBody(configuration: Configuration) -> some View {
		configuration.label
			.padding()
			.background(Color.blue)
			.foregroundColor(.white)
			.clipShape(Capsule())
			.opacity(configuration.isPressed ? 0.7 : 1)
	}
}

struct ExampleView7: View {
    var body: some View {
		VStack {
			Button {
				print("Button was pressed")
			} label: {
				Text("Press Me")
			}
			.buttonStyle(CancellableButtonStyle())
		}
    }
}

struct ExampleView7_Previews: PreviewProvider {
    static var previews: some View {
        ExampleView7()
    }
}
