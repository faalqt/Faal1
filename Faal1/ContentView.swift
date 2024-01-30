//
//  ContentView.swift
//  f1 stats
//
//  Created by Justin on 8/8/23.
//
import SwiftUI

// swiftLint:disable trailing whitespace
struct ContentView: View {
    @State private var f1Data: F1Data?
    @State private var selectedSeason: String = "2023"
    @State private var isLoading: Bool = false
    
    var seasons = ["2023", "2022", "2021", "2020", "2019", "2018", "2017", "2016", "2015", "2014", "2013"]
    
    var body: some View {
        ZStack {
            VStack {
                Text("Standings")
                Form {
                    Picker("Pick a season", selection: $selectedSeason) {
                        ForEach(seasons, id: \.self) {
                            Text($0)
                        }
                    }
                    .onChange(of: selectedSeason) { newValue in
                        Task { await setData(year: newValue) }
                    }
                }
                .frame(maxHeight: 80)
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                
                
                let drivers = f1Data?.MRData.StandingsTable.StandingsLists[0].DriverStandings ?? []
                if isLoading {
                    Spacer()
                    ProgressView()
                    Spacer()

                } else {
                    ScrollView {
                        HStack {
                            Spacer()
                        }
                        ForEach(drivers, id: \.Driver.driverId) { driver in
                            DriverCard(driver: driver)
                        }
                    }
                }
            }
            .padding()
        }
        .task { await setData(year: selectedSeason) }
    }
    
    func setData(year: String) async {
        do {
            isLoading = true
            f1Data = try await getData(year: selectedSeason)
            isLoading = false
        } catch F1Error.invalidURL {
            print("invalid url")
        } catch F1Error.invalidResponse {
            print("invalid response")
        } catch F1Error.invalidData {
            print("invalid data")
        } catch {
            print("unexpected error")
        }
    }
    

    func getData(year: String) async throws -> F1Data {
        let endpoint = "https://ergast.com/api/f1/\(year)/driverStandings.json"
        guard let url = URL(string: endpoint) else { throw F1Error.invalidURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw F1Error.invalidResponse
        }
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(F1Data.self, from: data)
        } catch {
            print(error)
            throw F1Error.invalidData
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
