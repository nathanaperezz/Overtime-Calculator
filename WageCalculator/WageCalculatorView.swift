//
//  WageCalculatorView.swift
//  WageCalculator
//
//  Created by  Nathan Perez on 1/21/26.
//

import SwiftUI

struct WageCalculatorView: View {
    
    @State var rate = ""
    @State var hoursWorked = ""
    @State var overtimeStructure = 1.5
    //@State var timeUnit = "week"
    @State var timeUnit = "day"
    
    @State var hoursSunday = ""
    @State var hoursMonday = ""
    @State var hoursTuesday = ""
    @State var hoursWednesday = ""
    @State var hoursThursday = ""
    @State var hoursFriday = ""
    @State var hoursSaturday = ""
    
    var hourlyRate: Double {
        Double(rate) ?? 0
    }
    
    var hours: Double {
        if(timeUnit == "week") {
            return Double(hoursWorked) ?? 0
        } else if(timeUnit == "day") {
            let sunday = Double(hoursSunday) ?? 0
            let monday = Double(hoursMonday) ?? 0
            let tuesday = Double(hoursTuesday) ?? 0
            let wednesday = Double(hoursWednesday) ?? 0
            let thursday = Double(hoursThursday) ?? 0
            let friday = Double(hoursFriday) ?? 0
            let saturday = Double(hoursSaturday) ?? 0
            
            return sunday + monday + tuesday + wednesday + thursday + friday + saturday
        } else {
            return 0
        }
    }
    
    var overtimeHourlyRate: Double {
        hourlyRate * overtimeStructure
    }
    
    var regularPay: Double {
        hourlyRate * min(hours, 40)
    }
    
    var overtimePay: Double {
        max(hours - 40, 0) * overtimeHourlyRate
    }
    
    var totalPay: Double {
        regularPay + overtimePay
    }
    
    var yearlyRegularPay: Double {
        regularPay * 52
    }
    
    var yearlyOvertimePay: Double {
        overtimePay * 52
    }
    
    var yearlyPay: Double {
        yearlyRegularPay + yearlyOvertimePay
    }
    
    var averageHourlyRate: Double {
        if(hours > 0) {
            return totalPay / hours
        } else {
            return 0
        }
    }
    
    var body: some View {
        ScrollView {
            
            VStack {
                Text("Pay Calculator")
                    .font(.title2)
                    .padding()
                
                GroupBox {
                    VStack {
                        Label("Hourly Wage", systemImage: "dollarsign")
                        TextField("0", text: $rate)
                            .keyboardType(.decimalPad)
                        //.background(Color(.systemBackground))
                            .font(.title2)
                            .glassEffect()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: 150)
                        //.textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        HStack() {
                            Label("Hours", systemImage: "clock")
                            Picker("Hours Worked", selection: $timeUnit) {
                                Text("total").tag("week")
                                Text("each day").tag("day")
                            }
                            .buttonStyle(.glass)
                        }
                        if(timeUnit == "week") {
                            TextField("0", text: $hoursWorked)
                                .keyboardType(.decimalPad)
                                .font(.title2)
                                .glassEffect()
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: 150)
                        }
                        if(timeUnit == "day") {
                            HStack()
                            {
                                Text("Sunday")
                                TextField("0 ", text: $hoursSunday)
                                    .keyboardType(.decimalPad)
                                    .glassEffect()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 80)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            HStack()
                            {
                                Text("Monday")
                                TextField("0 ", text: $hoursMonday)
                                    .keyboardType(.decimalPad)
                                    .glassEffect()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 80)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            HStack()
                            {
                                Text("Tuesday")
                                TextField("0 ", text: $hoursTuesday)
                                    .keyboardType(.decimalPad)
                                    .glassEffect()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 80)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            HStack()
                            {
                                Text("Wednesday")
                                TextField("0 ", text: $hoursWednesday)
                                    .keyboardType(.decimalPad)
                                    .glassEffect()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 80)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            HStack()
                            {
                                Text("Thursday")
                                TextField("0 ", text: $hoursThursday)
                                    .keyboardType(.decimalPad)
                                    .glassEffect()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 80)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            HStack()
                            {
                                Text("Friday")
                                TextField("0 ", text: $hoursFriday)
                                    .keyboardType(.decimalPad)
                                    .glassEffect()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 80)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            HStack()
                            {
                                Text("Saturday")
                                TextField("0 ", text: $hoursSaturday)
                                    .keyboardType(.decimalPad)
                                    .glassEffect()
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: 80)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            
                            
                            HStack {
                                Text("Total hours: ")
                                Text("\(hours, specifier: "%.2f")")
                                    .monospacedDigit()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                        HStack()
                        {
                            Label("Overtime multiplier", systemImage: "arrow.up.right")
                            Picker("Overtime multiplier", selection: $overtimeStructure) {
                                Text("1x").tag(1.0)
                                Text("1.5x").tag(1.5)
                                Text("2x").tag(2.0)
                                
                            }
                        }
                        .pickerStyle(.menu)
                        .buttonStyle(.glass)
                    }
                    .frame(maxWidth: 300)
                    
                    .frame(maxWidth: .infinity)
                }
                
                GroupBox {
                    Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 8) {
                        GridRow {
                            Text("Regular: ")
                            Text("$\(regularPay, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        GridRow {
                            Text("Overtime: ")
                            Text("$\(overtimePay, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        GridRow {
                            Text("Total: ")
                            Text("$\(totalPay, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .fontWeight(.bold)
                        }
                    }
                } label: {
                    Text("Weekly")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                
                GroupBox {
                    Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 8) {
                        GridRow {
                            Text("Regular: ")
                            Text("$\(yearlyRegularPay, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        GridRow {
                            Text("Overtime: ")
                            Text("$\(yearlyOvertimePay, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        GridRow {
                            Text("Total: ")
                            Text("$\(yearlyPay, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .fontWeight(.bold)
                        }
                    }
                } label: {
                    Text("Yearly")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                GroupBox {
                    Grid(alignment: .leading, horizontalSpacing: 12, verticalSpacing: 8) {
                        GridRow {
                            Text("Regular: ")
                            Text("$\(hourlyRate, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        GridRow {
                            Text("Overtime: ")
                            Text("$\(overtimeHourlyRate, specifier: "%.2f")")
                                .monospacedDigit()
                                .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        GridRow {
                            Text("Average: ")
                            if(averageHourlyRate == 0) {
                                Text("-")
                                    .monospacedDigit()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            } else {
                                Text("$\(averageHourlyRate, specifier: "%.2f")")
                                    .monospacedDigit()
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                        }
                    }
                } label: {
                    Text("Rates")
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .padding()
        }
        
    }
}

#Preview {
    WageCalculatorView()
}
