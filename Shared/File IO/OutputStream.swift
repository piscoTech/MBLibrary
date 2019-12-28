//
//  OutputStream.swift
//  MBLibrary
//
//  Created by Marco Boschi on 22/12/2019.
//  Copyright © 2019 Marco Boschi. All rights reserved.
//

import Foundation

extension OutputStream {

	public enum Error: Swift.Error {
		case notDataConvertible, failure(Swift.Error?), notAllDataWritten(Int)
	}

    /// Write a `String` to the receiver.
	///
	/// Original code https://stackoverflow.com/a/39579901/5031210
    ///
    /// - parameter string:                The string to write.
    /// - parameter encoding:              The String.Encoding to use when writing the string. This will default to UTF8.
    /// - parameter allowLossyConversion:  Whether to permit lossy conversion when writing the string.
	///
	/// - throws: `OutputStream.Error.notDataConvertible` if `Data` cannot be obtained, `.failure` if the underlying write fails or `.notAllDataWritten` if not all bytes could be written, reporting how many have been.
    public func write(_ string: String, encoding: String.Encoding = String.Encoding.utf8, allowLossyConversion: Bool = true) throws {
		guard let data = string.data(using: encoding, allowLossyConversion: allowLossyConversion) else {
			throw Error.notDataConvertible
        }

        try write(data)
    }

	/// Write `Data` to the receiver.
	///
	/// Original code https://stackoverflow.com/a/39579901/5031210
    ///
    /// - parameter data: The data to write.
	///
	/// - throws: `OutputStream.Error.failure` if the underlying write fails or `.notAllDataWritten` if not all bytes could be written, reporting how many have been.
	public func write(_ data: Data) throws {
		var bytesRemaining = data.count
		guard bytesRemaining > 0 else {
			return
		}

		var totalBytesWritten = 0

		while bytesRemaining > 0 {
			let bytesWritten = data.withUnsafeBytes {
				self.write(
					$0.bindMemory(to: UInt8.self).baseAddress!.advanced(by: totalBytesWritten),
					maxLength: bytesRemaining
				)
			}

			if bytesWritten < 0 {
				// "Can not OutputStream.write(): \(self.streamError?.localizedDescription)"
				throw Error.failure(self.streamError)
			} else if bytesWritten == 0 {
				// "OutputStream.write() returned 0"
				break
			}

			bytesRemaining -= bytesWritten
			totalBytesWritten += bytesWritten
		}

		guard totalBytesWritten == data.count else {
			throw Error.notAllDataWritten(totalBytesWritten)
		}
	}

}
