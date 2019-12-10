//
//  CameraResultView.swift
//  Photohms
//
//  Created by Student on 12/10/19.
//  Copyright © 2019 Student. All rights reserved.
//

import SwiftUI

struct CameraResultView: View {
    var body: some View {
        
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
                  ForEach(self.image?.getPixels()[100] ?? [], id: \.self) { color in
                    
                    Text(" the value is \(color)")
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
    }
}

struct CameraResultView_Previews: PreviewProvider {
    static var previews: some View {
        CameraResultView()
    }
}
