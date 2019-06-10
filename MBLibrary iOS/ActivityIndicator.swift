//
//  ActivityIndicator.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 09/06/2019.
//  Copyright © 2019 Marco Boschi. All rights reserved.
//

import SwiftUI
import Combine

@available(iOS 13.0, *)
public struct ActivityIndicator : UIViewRepresentable {
	public let style: UIActivityIndicatorView.Style
	private let animating: Binding<Bool>

	public init(style: UIActivityIndicatorView.Style, animating: Binding<Bool> = Binding.constant(true)) {
		self.style = style
		self.animating = animating
	}

	public func makeUIView(context: Context) -> UIActivityIndicatorView {
		let indicator = UIActivityIndicatorView(style: style)

		return indicator
	}

	public func updateUIView(_ indicator: UIActivityIndicatorView, context: Context) {
		if animating.value {
			indicator.startAnimating()
		} else {
			indicator.stopAnimating()
		}
	}
}

#if DEBUG
struct ActivityIndicator_Previews : PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}
#endif
