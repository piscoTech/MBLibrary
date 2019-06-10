//
//  MessageCell.swift
//  MBLibrary iOS
//
//  Created by Marco Boschi on 10/06/2019.
//  Copyright © 2019 Marco Boschi. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
public struct MessageCell: View {
	public let text: LocalizedStringKey
	public let hasActivityIndicator: Bool

	public init(_ text: LocalizedStringKey, withActivityIndicator: Bool = false) {
		self.text = text
		self.hasActivityIndicator = withActivityIndicator
	}

	public var body: some View {
		HStack {
			if hasActivityIndicator {
				ActivityIndicator(style: .medium)
			}
			Text(text)
		}
	}
}
