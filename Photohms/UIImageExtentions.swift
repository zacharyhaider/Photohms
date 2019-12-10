//
//  UIImageExtentions.swift
//  CameraTest
//
//  Created by Student on 12/2/19.
//  Copyright © 2019 Student. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

extension UIImage {
    func getPixels() -> [[CGFloat]] {
        guard let cgImage = self.cgImage else {
            return []
        }
        guard let imageData = cgImage.dataProvider?.data as Data? else {
            return []
        }
        let buffer = UnsafeMutableBufferPointer<UInt32>.allocate(capacity: cgImage.width * cgImage.height)
        _ = imageData.copyBytes(to: buffer)
        print(cgImage.height)
        print(cgImage.width)
        print(cgImage.width * cgImage.height)
        var result = [[CGFloat]]()
        var tempColor = ""
        var currentColor = ""
        for pixel in ((((cgImage.width * cgImage.height)/2)-1000)...(((cgImage.width * cgImage.height)/2)+1000)) {
            let r = buffer[pixel] & 255
            let g = (buffer[pixel] >> 8) & 255
            let b = (buffer[pixel] >> 16) & 255
            let color = [CGFloat(r), CGFloat(g),CGFloat(b)]
            result.append(color)
            currentColor = identifyColor(red: Int(r), green: Int(g), blue: Int(b))
            if (tempColor != currentColor){
                print(currentColor)
                tempColor = currentColor
            }
        }
        
        return result
    }
    
    func getColors()->[String]{
        var colors = [""]
        for pixel in self.getPixels(){
            colors.append( identifyColor(red: Int(pixel[0]), green: Int(pixel[1]), blue: Int(pixel[2])))
        }
        return colors
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
