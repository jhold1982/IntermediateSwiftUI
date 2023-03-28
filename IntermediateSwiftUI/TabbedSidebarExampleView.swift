//
//  TabbedSidebarExampleView.swift
//  IntermediateSwiftUI
//
//  Created by Justin Hold on 3/28/23.
//

// MARK: Creating a TabbedSidebar that handles both tab view and sidebar

import SwiftUI

struct TitledView {
	// Three properties
	let title: String
	let icon: Image
	let view: AnyView
	
	// initializer generic over any kind of view
	init<T: View>(title: String, systemImage: String, view: T) {
		self.title = title
		self.icon = Image(systemName: systemImage)
		self.view = AnyView(view)
	}
}

struct TabbedSidebar: View {
	@Environment(\.horizontalSizeClass) var sizeClass
	@State private var selection: String? = ""
	private let views: [TitledView]
	var body: some View {
		if sizeClass == .compact {
			TabView(selection: $selection) {
				ForEach(views, id: \.title) { item in
					item.view
						.tabItem {
							Text(item.title)
							item.icon
						}
						.tag(item.title)
				}
			}
		} else {
			NavigationStack {
				List(selection: $selection) {
					ForEach(views, id: \.title) { item in
						NavigationLink(
							destination: item.view,
							tag: item.title,
							selection: $selection
						) {
							Label {
								Text(item.title)
							} icon: {
								item.icon
							}
						}
						.tag(item.title)
					}
				}
				.listStyle(SidebarListStyle())
			}
		}
	}
	init(content: [TitledView]) {
		views = content
		_selection = State(wrappedValue: content[0].title)
	}
}

struct TabbedSidebarExampleView: View {
    var body: some View {
        TabbedSidebar(content: [
			TitledView(title: "Home", systemImage: "house", view: Text("Home")),
			TitledView(title: "Buy", systemImage: "cart", view: Text("Buy")),
			TitledView(title: "Account", systemImage: "person.circle", view: Text("Account"))
		])
    }
}

struct TabbedSidebarExampleView_Previews: PreviewProvider {
    static var previews: some View {
        TabbedSidebarExampleView()
    }
}
