//
//  ContentView.swift
//  Photohms
//
//  Created by Student on 12/9/19.
//  Copyright © 2019 Student. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var tempColor = ""
    private var currentColor = ""
    
    @State private var selection = 0
    @State var image: UIImage? = nil
    @State var showCaptureImageView: Bool = false
    var body: some View {
        TabView(selection: $selection){
            ResistorBand()
                .font(.title)
                .tabItem {
                    VStack {
                        Image("first")
                        Text("Manual Input")
                    }
            }
            .tag(0)
            
            
            ZStack{
                VStack {
                    Button(
                        action: {
                            self.image = nil
                            self.showCaptureImageView.toggle()
                    })
                    {
                        Text("Choose photos")
                    }
                    ForEach(self.image?.getPixels() ?? [], id: \.self) { color in
                       
                        Text(" the value is \(self.identifyColor(red: Int(color[0]), green: Int(color[1]), blue: Int(color[2])))")
                    }
                    
                }
                
                if (showCaptureImageView) {
                    ZStack{
                        CaptureImageView(isShown: $showCaptureImageView, image: $image)
                        Rectangle()
                            .stroke(lineWidth: 5)
                            .frame(width: 200, height: 200 , alignment: .center)
                        
                    }
                }
            }
            .font(.title)
            .tabItem {
                VStack {
                    Image(systemName: "camera.fill")
                    Text("Photo calculator")
                }
            }
            .tag(1)
        }
    }

 func returnColor(c:String)-> String{
        if (c != self.tempColor){
            return c
        }
    return""
    }
    
func identifyColor(red: Int, green: Int, blue: Int)->String{
        if(red==blue && green == blue && red > 0){
            return "Black"
        }
        if(red==blue && green == blue && red == 0){
            return "white"
        }
        if (red>blue && red>=green){
            if (abs(blue-red)>50 ){
                return "purple"
            }
            else{
                if((red/2)<green-10){
                    if(red-green>50){
                        return "orange"
                    }
                    else{
                        return "yellow"
                    }
                }
                else{
                    return "red"
                }
            }
        }
        else{
            if (blue>green){
                return "blue"
            }
            else{
                return "green"
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
