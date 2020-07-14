//
//  PullToRefresh.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 12/07/2020.
//  Original code by Loïs Di Qual (MIT Licence)
//  https://github.com/siteline/SwiftUIRefresh/blob/master/Sources/PullToRefresh.swift
//  Copyright © 2020 Marco Boschi. All rights reserved.
//

import SwiftUI
import UIKit

@available(iOS 13.0, *)
struct PullToRefresh: UIViewRepresentable {
	let action: () -> Void
	@Binding var isShowing: Bool

	func makeUIView(context: Context) -> UIView {
		let view = UIView(frame: .zero)
		view.isHidden = true
		view.isUserInteractionEnabled = false

		return view
	}

	private func scrollView(root: UIView) -> UIScrollView? {
		for subview in root.subviews {
			if let scroll = subview as? UIScrollView {
				return scroll
			} else if let scroll = scrollView(root: subview) {
				return scroll
			}
		}

		return nil
	}

	func updateUIView(_ uiView: UIView, context: Context) {
		DispatchQueue.main.async {
			guard let viewHost = uiView.superview?.superview else {
				return
			}
			guard let scroll = self.scrollView(root: viewHost) else {
				return
			}

			if let refreshControl = scroll.refreshControl {
				if self.isShowing {
					refreshControl.beginRefreshing()
				} else {
					refreshControl.endRefreshing()
				}

				return
			}

			let refreshControl = UIRefreshControl()
			refreshControl.addTarget(context.coordinator, action: #selector(Coordinator.onValueChanged), for: .valueChanged)
			scroll.refreshControl = refreshControl
		}
	}

	func makeCoordinator() -> Coordinator {
		return Coordinator(self)
	}

	class Coordinator {
		let view: PullToRefresh

		init(_ view: PullToRefresh) {
			self.view = view
		}

		@objc func onValueChanged() {
			view.isShowing = true
			view.action()
		}

	}

}

@available(iOS 13.0, *)
extension View {
	public func pullToRefresh(isShowing: Binding<Bool>, onRefresh: @escaping () -> Void) -> some View {
		VStack(spacing: 0) {
			// Keep the original view first, a must to have nice animation with large titles
			self
			PullToRefresh(action: onRefresh, isShowing: isShowing).frame(width: 0, height: 0)
		}
	}
}
