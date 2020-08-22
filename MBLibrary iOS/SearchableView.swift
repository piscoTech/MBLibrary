//
//  SearchableView.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 14/07/2020.
//  Copyright © 2020 Marco Boschi. All rights reserved.
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct SearchableView: UIViewRepresentable {
	fileprivate let text: Binding<String?>?
	fileprivate let scopes: [String]?
	fileprivate let scope: Binding<Int?>?
	
	func makeUIView(context: Context) -> UIView {
		let view = UIView(frame: .zero)
		view.isHidden = true
		view.isUserInteractionEnabled = false

		return view
	}

	private func parentController(root: UIView) -> UIViewController? {
		var parentResponder: UIResponder? = root
        while let p = parentResponder {
            parentResponder = p.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }

        return nil
	}

	func updateUIView(_ uiView: UIView, context: Context) {
		DispatchQueue.main.async {
			guard let controller = self.parentController(root: uiView) else {
				return
			}

			if let search = controller.navigationItem.searchController {
				context.coordinator.updateSearchResults(for: search)
				return
			}

			controller.navigationItem.searchController = context.coordinator.search
			controller.navigationItem.hidesSearchBarWhenScrolling = true
			controller.definesPresentationContext = true
		}
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(self)
	}

	class Coordinator: NSObject, UISearchResultsUpdating, UISearchBarDelegate {
		let view: SearchableView
		let search: UISearchController

		init(_ view: SearchableView) {
			self.view = view
			self.search = UISearchController(searchResultsController: nil)
			super.init()

			search.searchResultsUpdater = self
			search.dimsBackgroundDuringPresentation = false
			search.searchBar.scopeButtonTitles = view.scopes
			search.searchBar.delegate = self
		}

		func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
			guard let scope = view.scope else {
				return
			}

			if (search.searchBar.scopeButtonTitles?.isEmpty ?? true) || !search.isActive {
				scope.wrappedValue = nil
			} else {
				scope.wrappedValue = selectedScope
			}
		}

		func updateSearchResults(for searchController: UISearchController) {
			guard let text = view.text else {
				return
			}

			if search.isActive != (text.wrappedValue != nil) {
				self.searchBar(search.searchBar, selectedScopeButtonIndexDidChange: search.searchBar.selectedScopeButtonIndex)
			}

			if search.isActive {
				text.wrappedValue = search.searchBar.text ?? ""
			} else {
				text.wrappedValue = nil
			}
		}

	}

}

@available(iOS 13.0, *)
extension View {
	private func anySearchable(text: Binding<String?>? = nil, scopes: [String]? = nil, scope: Binding<Int?>? = nil) -> some View {
		VStack(spacing: 0) {
			// Keep the original view first, a must to have nice animation with large titles
			self
			SearchableView(text: text, scopes: scopes, scope: scope).frame(width: 0, height: 0)
		}
	}

	public func searchable(text: Binding<String?>) -> some View {
		return anySearchable(text: text, scopes: nil, scope: nil)
	}

	public func searchable(text: Binding<String?>, scopes: [String], scope: Binding<Int?>) -> some View {
		return anySearchable(text: text, scopes: scopes, scope: scope)
	}

}
