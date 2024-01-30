//
//  DriverView.swift
//  f1 stats
//
//  Created by Justin on 8/15/23.
//

import SwiftUI

struct DriverCard: View {
    @State private var showingDriver: Bool = false
    var driver: DriverStandings
    
    var body: some View {
        VStack{
            Button {
                showingDriver.toggle()
            } label: {
                HStack (alignment: .center) {
                    Text("\(driver.position)")
                        .font(.title2)
                        .frame(alignment: .trailing)
                        .shadow(color: .black, radius: 5)
                    VStack (alignment: .leading) {
                        Text("\(driver.Driver.givenName) \(driver.Driver.familyName)")
                            .font(.headline)
                            .shadow(color: .black, radius: 5)
                        Text("\(driver.Constructors.first?.name ?? "Team not found")")
//                            .foregroundStyle(getTeamColor(of: driver.Constructors.first?.constructorId ?? "na"))
                            .shadow(color: .black, radius: 5)
                    }
                    Spacer()
                    Text("\(driver.points)")
                        .font(.headline)
                        .fontWeight(.regular)
                        .shadow(color: .black, radius: 5)
                }
                .foregroundColor(.white)
            }
            .padding(.all, 10)
            .padding(.vertical, 5)
        }
        .background(getTeamColor(of: driver.Constructors.first?.constructorId ?? "na")
//            LinearGradient(gradient: Gradient(stops: [
//                Gradient.Stop(color: Color("dark_gray"), location: 0.3),
//                Gradient.Stop(color: getTeamColor(of: driver.Constructors[0].constructorId), location: 1)
//            ]), startPoint: .leading, endPoint: .trailing)
        )
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .padding(.bottom, 5)
        .padding(.horizontal, 10)
        .foregroundColor(.primary)
        .sheet(isPresented: $showingDriver) {
            DriverSheetView(driver: driver, constructor: driver.Constructors[0].constructorId)
                .presentationDetents([.medium])
        }
    }
}

struct DriverSheetView: View {
    var driver: DriverStandings
    var constructor: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(getNationality(driver.Driver.nationality))")
                Text("\(driver.Driver.givenName) \(driver.Driver.familyName)")
            }
            .padding(.top, 30.0)
            .font(.largeTitle)
            .fontWeight(.medium)
            
            
            HStack{
                Text("\(driver.Constructors[0].name)")
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(getTeamColor(of: constructor))
            }
            
            
            HStack {
                VStack (alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack (alignment: .leading) {
                        Text("Nationality")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        Text("\(driver.Driver.nationality)")
                    }
                    
                    VStack (alignment: .leading) {
                        Text("Date of Birth")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        Text("\(driver.Driver.dateOfBirth)")
                            .font(.headline)
                            .fontWeight(.regular)
                            
                    }
                    
                }
                Spacer()
                VStack (alignment: .trailing, spacing: 10) {
                    Text("Season")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    VStack (alignment: .trailing) {
                        Text("Points")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        
                        Text("\(driver.points)")
                    }
                    
                    VStack (alignment: .trailing) {
                        Text("Wins")
                            .font(.subheadline)
                            .fontWeight(.medium)
                            .foregroundColor(.secondary)
                        Text("\(driver.wins)")
                            .font(.headline)
                            .fontWeight(.regular)
                            
                    }
                }
            }
            .padding(.horizontal, 50.0)
            .padding(.top, 20.0)
            HStack {
                Link("Read more...", destination: URL(string: driver.Driver.url)!)
                    .font(.subheadline)
                Spacer()
            }
            .padding(.horizontal, 50.0)
            .padding(.vertical, 10)
            Spacer()
        }
            
    }
}

func getNationality(_ nat: String) -> String {
    switch nat{
    case "British":
        return "🇬🇧"
    case "Spanish":
        return "🇪🇸"
    case "Dutch":
        return "🇳🇱"
    case "Finnish":
        return "🇫🇮"
    case "French":
        return "🇫🇷"
    case "Australian":
        return "🇦🇺"
    case "German":
        return "🇩🇪"
    case "Thai":
        return "🇹🇭"
    case "Canadian":
        return "🇨🇦"
    case "Danish":
        return "🇩🇰"
    case "Italian":
        return "🇮🇹"
    case "Mexican":
        return "🇲🇽"
    case "Monegasque":
        return "🇲🇨"
    case "Chinese":
        return "🇨🇳"
    case "Japanese":
        return "🇯🇵"
    case "American":
        return "🇺🇸"
    default:
        return "🏁"
    }
}

func getTeamColor(of teamName: String) -> Color {
    switch teamName {
    case "ferrari":
        return Color("ferrari")
    case "mclaren":
        return Color("mclaren")
    case "alfa":
        return Color("alfa")
    case "alphatauri":
        return Color("alphatauri")
    case "alpine":
        return Color("alpine")
    case "aston_martin":
        return Color("aston_martin")
    case "mercedes":
        return Color("mercedes")
    case "red_bull":
        return Color("red_bull")
    case "williams":
        return Color("williams")
    case "haas":
        return Color("haas")
    default:
        return Color("unknown_team")
    }
}
