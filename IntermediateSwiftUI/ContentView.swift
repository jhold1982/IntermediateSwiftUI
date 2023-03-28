//
//  ContentView.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/22/23.
//

import SwiftUI

struct ContentView: View {
	@State private var selectedTab = 0
    var body: some View {
		TabView(selection: $selectedTab) {
			ExampleView1().tag(0)
				.tabItem {
					Label("View 1", systemImage: "star")
				}
			ExampleView2().tag(1)
				.tabItem {
					Label("View 2", systemImage: "pill")
				}
			ExampleView3().tag(2)
				.tabItem {
					Label("View 3", systemImage: "lasso.and.sparkles")
				}
			ExampleView7().tag(3)
				.tabItem {
					Label("View 4", systemImage: "timer.circle")
				}
		}
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
