//
//  F1Data.swift
//  f1 stats
//
//  Created by Justin on 8/15/23.
//

import SwiftUI

struct F1Data: Codable {
    let MRData: MRData
}

struct MRData: Codable {
    let StandingsTable: StandingsTable
}

struct StandingsTable: Codable {
    let season: String
    let StandingsLists: [StandingsLists]
}

struct StandingsLists: Codable {
    let season: String
    let round: String
    let DriverStandings: [DriverStandings]
}

struct DriverStandings: Codable {
    let position: String
    let points: String
    let wins: String
    let Driver: Driver
    let Constructors: [Constructors]
}

struct Driver: Codable {
    let driverId: String
    let givenName: String
    let familyName: String
    let code: String
    let nationality: String
    let dateOfBirth: String
    let permanentNumber: String
    let url: String
}

struct Constructors: Codable {
    let constructorId: String
    let name: String
    let nationality: String
}

enum F1Error: Error {
    case invalidURL, invalidResponse, invalidData
}
