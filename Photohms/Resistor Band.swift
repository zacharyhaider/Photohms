//
//  Resistor Band.swift
//  Photohms
//
//  Created by Student on 12/9/19.
//  Copyright © 2019 Student. All rights reserved.
//

import SwiftUI

import Foundation
precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ** : PowerPrecedence
func ** (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}




struct ResistorBand: View {
    public let colors = ["Black", "Brown", "Red", "Orange", "Yellow","Green", "Blue", "Violet","Grey","White"]
    public let tempLabelColors = [ "Brown", "Red", "Orange", "Yellow","Blue", "Violet","White"]
    private var toleranceLableColors = ["Brown","Red","Gold","Silver"]
   
    public let bandColors = [Color.black,Color.orange, Color.red,Color.orange, Color.yellow,Color.green,Color.blue,Color.purple,Color.gray,Color.gray]
    public let tempColors = [Color.orange, Color.red,Color.orange, Color.yellow,Color.blue,Color.purple,Color.gray]
    public let tolColors = [Color.orange, Color.red,Color.yellow,Color.gray]
    
    @State private var bands = [0,0,0,0,0]
    @State private var tolerance = 0
    @State private var temp = 0
    @State private var numBands = 4
    var body: some View {
        ZStack {
            Color.init(red: 200/255, green: 224/255, blue: 232/255)
                .edgesIgnoringSafeArea(.all)
            VStack {
                
                
                Text(ohmsCalc( numBands: self.numBands, bands: self.bands)).padding(.top,100)
                
                Text("Tolerance = ±\( toleranceCalc(t:self.tolerance))%")
                if(self.numBands==6){
                    Text("Temperature Coefficient =  \(tempCalc(t:self.temp))")}
                
                Button(action: {
                    if (self.numBands<6 ){
                        self.numBands+=1
                    }
                }){Text("+")}.padding(.top,100)
                HStack {
                    Text("Number of bands")
                    Text("\(self.numBands)")
                }
                Button(action: {
                    if (self.numBands>4){
                        self.numBands-=1
                    }
                }){Text("-")}
                
                
                
                GeometryReader { geometry in
                    HStack
                        {
                            if(self.numBands > 4){
                                Picker(selection: self.$bands[0], label: Text("")) {
                                    ForEach(0 ..< self.colors.count) {
                                        Text(self.colors[$0]).foregroundColor(self.bandColors[$0])
                                    }
                                }
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width: (geometry.size.width / CGFloat(self.numBands))-10, height: geometry.size.height, alignment: .center)
                                .clipped()
                                
                            }
                            ForEach((1...3 ), id: \.self) {x in
                                Picker(selection: self.$bands[x], label: Text("")) {
                                    ForEach(0 ..< self.colors.count) {
                                        Text(self.colors[$0]).foregroundColor(self.bandColors[$0])
                                    }
                                }
                                .fixedSize(horizontal: true, vertical: true)
                                .frame(width: (geometry.size.width / CGFloat(self.numBands))-10, height: geometry.size.height, alignment: .center)
                                .clipped()
                                
                            }
                            
                            Picker(selection: self.$tolerance, label: Text("")) {
                                ForEach(0 ..< self.toleranceLableColors.count) {
                                    Text(self.toleranceLableColors[$0]).foregroundColor(self.tolColors[$0])
                                }
                                
                            }
                            .fixedSize(horizontal: true, vertical: true)
                            .frame(width: (geometry.size.width / CGFloat(self.numBands))-10, height: geometry.size.height, alignment: .center)
                            .clipped()
                            
                            
                            if(self.numBands == 6){
                                
                                
                                Picker(selection: self.$temp, label: Text("")) {
                                    ForEach(0 ..< self.tempLabelColors.count) {
                                        Text(self.tempLabelColors[$0]).foregroundColor(self.tempColors[$0])
                                    }
                                    
                                } .fixedSize(horizontal: true, vertical: true)
                                    .frame(width: (geometry.size.width / CGFloat(self.numBands))-10, height: geometry.size.height, alignment: .center)
                                    .clipped()
                            }
                    }.padding(10)
                    
                    Spacer()
                }
                
            }
        }
    }
    
}

func ohmsCalc( numBands: Int, bands:[Int])->String{
    var value = 0
    if(numBands == 4){
        value = (((bands[0]*0)+bands[1]*10+(bands[2]))*(10**(bands[3])))
    }
    else{
        value = (((bands[0]*100)+bands[1]*10+(bands[2]))*(10**(bands[3])))}
    if value >= 1000000{
        value = value/1000000
        return "\(value) M Ω"
    }
    else if value > 1000{
        value = value/1000
        return "\(value) K Ω"
    }
    else{
        return "\(value) Ω"
    }
}
func toleranceCalc(t: Int)->String{
    print(t)
    switch t {
    case 0:
        return "1"
    case 1:
        return "2"
    case 2:
        return "5"
    case 3:
        return "10"
    default:
        return "0"
    }
}
func tempCalc(t: Int)->String{
    print(t)//brogbvs
    switch t {
    case 0:
        return "100"
    case 1:
        return "50"
    case 2:
        return "15"
    case 3:
        return "25"
    case 4:
        return "10"
    case 5:
        return "5"
    case 6:
        return "1"
    default:
        return "0"
    }
}
struct ResistorBand_Previews: PreviewProvider {
    static var previews: some View {
        ResistorBand()
    }
}


