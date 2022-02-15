//
//  DetailsView.swift
//  Filmes Populares
//
//  Created by Matheus Curticeiro on 10/02/22.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

struct DetailsView: View{
    var movie: Movie
    @ObservedObject var viewModel: MovieViewModel
    @Environment(\.presentationMode) var presentation
    @State var yOffset: CGFloat = 30
    @State var opacity: Double = 0
    var body: some View{
        
        ZStack(alignment: .bottom){
      
        VStack{
            ZStack (alignment: .top) {
                
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                .resizable()
                .aspectRatio(contentMode: .fit)
                
                HStack{
                    Button(action: {
                        presentation.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.left")
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                            .foregroundColor(Color.primary)
                    })
                    
                    Spacer()
                }
                .padding()
                .padding(.top)
            }
            Spacer()
            
        }
                
   
            VStack (spacing: 8) {
            HStack(alignment: .center, spacing: 8) {
            Text(movie.title)
                .font(.largeTitle)
                
                RatingView(rating: movie.vote_average)
                
                
                
                Spacer()
                 }
                HStack (spacing: 8 ){
                ForEach(viewModel.movie?.genres ?? Array.init(repeating: Genre(id: 0, name: "Carregando..."), count: 3)) {
                    genre in
                    Text(genre.name)
                        .redacted(reason: viewModel.movie == nil ? .placeholder: .init())
                    
                    if viewModel.movie?.genres?.last != genre{
                        Circle()
                            .frame(width: 6, height: 6)
                    }
                 }
                    
                    Spacer()
                }
                
                Text(movie.overview ?? "")
                
                Button(action: {}, label:{
                    HStack{
                        Image(systemName: "play.fill")
                        
                    Text("Assistir ao trailer.")
                    }
                    .foregroundColor(Color.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.primary, lineWidth: 1))
                    .padding(.top)
                })
                    .padding(.bottom,UIApplication.shared.windows.first?.safeAreaInsets.bottom)
              }
            .padding()
            .background(RoundedCornes(coners: [.topLeft, .topRight], radius: 30).fill(Color.white).shadow(radius: 5))
            .cornerRadius(30)
            .animation(.spring())
            .opacity(opacity)
            .offset(y: yOffset)
            .onAppear {
                DispatchQueue.main.async {
                    withAnimation {
                    yOffset = 0
                    opacity = 1
                    }
                }
            }
           }
        .navigationBarHidden(true)
    .ignoresSafeArea(.all, edges: .all)
        .onAppear {
          viewModel.fetchMovie(movie: movie)
     }
  }
        
}

struct DetailsView_Previews:PreviewProvider {
    static var previews: some View{
        DetailsView(movie: Movie(id: 634649, title: "Spider-Man: No Way Home", overview: "Peter Parker is unmasked and no longer able to separate his normal life from the high-stakes of being a super-hero. When he asks for help from Doctor Strange the stakes become even more dangerous, forcing him to discover what it truly means to be Spider-Man.", poster_path: "/1g0dhYtq4irTY1GPXvft6k4YLjm.jpg", vote_average: 8.4, release_date: "2021-12-15", genres: nil), viewModel: MovieViewModel())
    }
}
