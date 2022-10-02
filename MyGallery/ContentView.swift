//
//  ContentView.swift
//  MyGallery
//
//  Created by Muhamad Arif on 30/09/22.
//

import SwiftUI

struct ContentView: View {
    
    @Namespace var namespace
    
    @State private var selectedImage: String?
    @State private var isAnimating: Bool = false
    @State private var imageOffset: CGSize = .zero
    @State private var imageScale: CGFloat = 1
    
    let images = ["image1", "image2", "image3", "image4", "image5", "image6", "image7", "image8", "image9"]
    
    func resetImageState() {
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    var body: some View {
        
        VStack {
            
            if selectedImage == nil {
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]) {
                    
                    ForEach(images, id: \.self) { image in
                        Image("\(image)")
                            .resizable()
                            .scaledToFit()
                            .font(.system(size: 40))
                            .padding()
                            .matchedGeometryEffect(id: image, in: namespace)
                            .onTapGesture {
                                selectedImage = image
                            }
                    }
                }.animation(.spring())
            } else if let selectedImage = selectedImage {
                VStack {
                    Image("\(selectedImage)")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 1500)
                        .font(.system(size: 70))
                        .matchedGeometryEffect(id: selectedImage, in: namespace)
                        .onTapGesture {
                            withAnimation {
                                self.selectedImage = nil
                            }
                            
                        }.animation(.spring())
                    
                        
                }
                .overlay(
                    Group {
                        HStack {
                            //SCALE DOWN
                            Button {
                                //some action
                                withAnimation(.spring()) {
                                    if imageScale > 1 {
                                        imageScale -= 1
                                        
                                        if imageScale <= 1 {
                                            resetImageState()
                                        }
                                    }
                                }
                            } label: {
                                ControlImageView(icon: "minus.magnifyingglass")
                            }

                            //RESET
                            Button {
                                //some action
                                resetImageState()
                            } label: {
                                ControlImageView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                            }
                            //SCALE UP
                            Button {
                                //some action
                                withAnimation(.spring()) {
                                    if imageScale <  5 {
                                        imageScale += 1
                                        
                                        if imageScale > 5 {
                                            imageScale = 5
                                        }
                                    }
                                }
                            } label: {
                                ControlImageView(icon: "plus.magnifyingglass")
                            }
                        }// : CONTROLS
                        .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                        .background(.ultraThinMaterial)
                        .cornerRadius(12)
                        .opacity(isAnimating ? 1 : 0)
                    }
                        .padding(.bottom, 30)
                    , alignment: .bottom
                )
                    
                
               
            }
        }

    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
