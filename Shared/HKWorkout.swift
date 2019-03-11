//
//  HKWorkout.swift
//  MBLibrary
//
//  Created by Marco Boschi on 12/11/2018.
//  Copyright © 2018 Marco Boschi. All rights reserved.
//

import Foundation
import HealthKit

fileprivate let resumeEvents = [HKWorkoutEventType.resume, .motionResumed]
fileprivate let pauseEvents = [HKWorkoutEventType.pause, .motionPaused]

extension HKWorkout {
	
	/// The periods of time when the workout was active.
	///
	/// The workout starts as active, the end of a segment is marked by a `.pause` or `.motionPaused` or the end of the workout, a new segment is started by a `.resume` or `.motionResumed` event.
	public var activeSegments: [DateInterval] {
		var events = self.workoutEvents ?? []
		// Remove non-useful events
		events = events.filter { resumeEvents.contains($0.type) || pauseEvents.contains($0.type) }
		// Remove any event at the beginning that's not a pause event
		if let pauseInd = events.index(where: { pauseEvents.contains($0.type) }) {
			events = Array(events.suffix(from: pauseInd))
		}
		var intervals = [DateInterval]()
		var intervalStart = self.startDate
		var fullyScanned = false
		
		// Calculate the intervals when the workout was active
		while !events.isEmpty {
			let pause = events.removeFirst()
			let end: Date
			if #available(iOS 11.0, watchOS 4.0, *) {
				end = pause.dateInterval.start
			} else {
				end = pause.date
			}
			intervals.append(DateInterval(start: intervalStart, end: end))
			
			if let resume = events.index(where: { resumeEvents.contains($0.type) }) {
				if #available(iOS 11.0, watchOS 4.0, *) {
					intervalStart = events[resume].dateInterval.start
				} else {
					intervalStart = events[resume].date
				}
				
				let tmpEv = events.suffix(from: resume)
				if let pause = tmpEv.index(where: { pauseEvents.contains($0.type) }) {
					events = Array(tmpEv.suffix(from: pause))
				} else {
					// Empty the array as at the next cycle we expect the first element to be a pause
					events = []
				}
			} else {
				// Run ended while paused
				fullyScanned = true
				break
			}
		}
		if !fullyScanned {
			intervals.append(DateInterval(start: intervalStart, end: self.endDate))
		}
		
		return intervals
	}
	
}
