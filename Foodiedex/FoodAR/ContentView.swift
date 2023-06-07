//
//  ContentView.swift
//  Foodiedex
//
//  Created by Yathartha Regmi on 5/30/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var translation: CGSize = .zero
    @State private var swipeStatus: SwipeStatus = .left
    @State private var currentImageIndex = 0


    var imageNames: [String] {
        guard let imageFiles = Bundle.main.urls(forResourcesWithExtension: "jpg", subdirectory: "Pics") else {
                return []
            }
            return imageFiles.map { $0.lastPathComponent }
        }

    var body: some View {
       
          VStack {
              if imageNames.isEmpty {
                  Text("No images found")
              }
              else if currentImageIndex >= 0 && currentImageIndex < imageNames.count {
                  // Need to strip .jpg because assets dont have the .jpg extension in their folder
                  let parsedImageName = imageNames[currentImageIndex].replacingOccurrences(of: ".jpg", with: "")
                  Image(parsedImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300, height: 300)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .offset(x: translation.width, y: translation.height)
                        .gesture(
                          DragGesture()
                              .onChanged { gesture in
                                  translation = gesture.translation
                              }
                              .onEnded { gesture in
                                  let thresholdPercentage: CGFloat = 0.4
                                  if abs(translation.width) > UIScreen.main.bounds.width * thresholdPercentage {
                                      swipeStatus = translation.width > 0 ? .right : .left
                                      updateImage()
                                  } else {
                                      translation = .zero
                                  }
                              }
                        )
                        .animation(.spring(), value: 0.8)
                        .transition(.slide)
              }

              Text(swipeStatus.rawValue)
                  .font(.title)
                  .padding()

        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8).edgesIgnoringSafeArea(.all))
    }
    
    func updateImage() {
        currentImageIndex = (currentImageIndex + 1) % imageNames.count
        translation = .zero
    }
}

enum SwipeStatus: String{
    case none, left, right
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
