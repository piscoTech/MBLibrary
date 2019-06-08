//
//  HealthKit.swift
//  MBLibrary
//
//  Created by Marco Boschi on 05/03/2017.
//  Copyright © 2017 Marco Boschi. All rights reserved.
//

import Foundation
import MBLibrary
import HealthKit

extension HKWorkoutActivityType {
	
	public var name: String {
		let wType: Int
		
		switch self {
		case .americanFootball:
			wType = 1
		case .archery:
			wType = 2
		case .australianFootball:
			wType = 3
		case .badminton:
			wType = 4
		case .baseball:
			wType = 5
		case .basketball:
			wType = 6
		case .bowling:
			wType = 7
		case .boxing:
			wType = 8
		case .climbing:
			wType = 9
		case .cricket:
			wType = 10
		case .crossTraining:
			wType = 11
		case .curling:
			wType = 12
		case .cycling:
			wType = 13
		case .dance:
			wType = 14
		case .danceInspiredTraining:
			wType = 15
		case .elliptical:
			wType = 16
		case .equestrianSports:
			wType = 17
		case .fencing:
			wType = 18
		case .fishing:
			wType = 19
		case .functionalStrengthTraining:
			wType = 20
		case .golf:
			wType = 21
		case .gymnastics:
			wType = 22
		case .handball:
			wType = 23
		case .hiking:
			wType = 24
		case .hockey:
			wType = 25
		case .hunting:
			wType = 26
		case .lacrosse:
			wType = 27
		case .martialArts:
			wType = 28
		case .mindAndBody:
			wType = 29
		case .mixedMetabolicCardioTraining:
			wType = 30
		case .paddleSports:
			wType = 31
		case .play:
			wType = 32
		case .preparationAndRecovery:
			wType = 33
		case .racquetball:
			wType = 34
		case .rowing:
			wType = 35
		case .rugby:
			wType = 36
		case .running:
			wType = 37
		case .sailing:
			wType = 38
		case .skatingSports:
			wType = 39
		case .snowSports:
			wType = 40
		case .soccer:
			wType = 41
		case .softball:
			wType = 42
		case .squash:
			wType = 43
		case .stairClimbing:
			wType = 44
		case .surfingSports:
			wType = 45
		case .swimming:
			wType = 46
		case .tableTennis:
			wType = 47
		case .tennis:
			wType = 48
		case .trackAndField:
			wType = 49
		case .traditionalStrengthTraining:
			wType = 50
		case .volleyball:
			wType = 51
		case .walking:
			wType = 52
		case .waterFitness:
			wType = 53
		case .waterPolo:
			wType = 54
		case .waterSports:
			wType = 55
		case .wrestling:
			wType = 56
		case .yoga:
			wType = 57
		case .barre:
			wType = 58
		case .coreTraining:
			wType = 59
		case .crossCountrySkiing:
			wType = 60
		case .downhillSkiing:
			wType = 61
		case .flexibility:
			wType = 62
		case .highIntensityIntervalTraining:
			wType = 63
		case .jumpRope:
			wType = 64
		case .kickboxing:
			wType = 65
		case .pilates:
			wType = 66
		case .snowboarding:
			wType = 67
		case .stairs:
			wType = 68
		case .stepTraining:
			wType = 69
		case .wheelchairWalkPace:
			wType = 70
		case .wheelchairRunPace:
			wType = 71
		case .taiChi:
			wType = 72
		case .mixedCardio:
			wType = 73
		case .handCycling:
			wType = 74
		case .discSports:
			wType = 75
		case .fitnessGaming:
			wType = 76
		case .other:
			fallthrough
		@unknown default:
			wType = 0
		}
		
		return MBLocalizedString("WORKOUT_NAME_\(wType)", comment: "Workout")
	}
	
}
