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

	class Coordinator: NSObject, UISearchResultsUpdating {
		let view: SearchableView
		let search: UISearchController

		init(_ view: SearchableView) {
			self.view = view
			self.search = UISearchController(searchResultsController: nil)
			super.init()

			search.searchResultsUpdater = self
			search.dimsBackgroundDuringPresentation = false
		}

		func updateSearchResults(for searchController: UISearchController) {
			print("Update results")
		}

	}

}

@available(iOS 13.0, *)
extension View {
	public func searchable() -> some View {
		VStack(spacing: 0) {
			// Keep the original view first, a must to have nice animation with large titles
			self
			SearchableView().frame(width: 0, height: 0)
		}
	}
}
