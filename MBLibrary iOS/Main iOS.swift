//
//  Main iOS.swift
//  MBLibrary
//
//  Created by Marco Boschi on 19/07/16.
//  Copyright © 2016 Marco Boschi. All rights reserved.
//

import UIKit

public let isIPad = {
	return UIDevice.current().userInterfaceIdiom == .pad
}()

public let isIPhone = {
	return UIDevice.current().userInterfaceIdiom == .phone
}()
