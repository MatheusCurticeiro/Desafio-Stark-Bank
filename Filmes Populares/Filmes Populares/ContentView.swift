//
//  ContentView.swift
//  Filmes Populares
//
//  Created by Matheus Curticeiro on 09/02/22.
//

import SwiftUI
import CoreData
import SDWebImageSwiftUI

struct ContentView: View{
    

    @StateObject var viewModel = MovieViewModel()
    
    
    var body: some View {
        NavigationView{
            
            ZStack {
                if let movies =  viewModel.movies {
                    MoviesListView(movies: movies, viewModel: viewModel)
                }else {
                LoadingView()
                }
            }
            .navigationTitle("Filmes Populares")
        }
        .onAppear{
                viewModel.fetchData()
            }
            
}
    }



struct MovieView: View {
    var movie: Movie
    
    var body: some View {
        HStack(spacing: 15) {
            WebImage(url: URL(string: "https://image.tmdb.org/t/p/w500/\(movie.poster_path)"))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 120)
                .cornerRadius(8)
            VStack(alignment: .leading, spacing: 8) {
            
            Text(movie.title)
            .font(.title2)
            .fontWeight(.semibold)
            
            Text(movie.overview ?? "")
                .lineLimit(4)
                .foregroundColor(.gray)
                
                Spacer()
                
                RatingView(rating: movie.vote_average)
                
                Text("Lançamento: \(movie.release_date)")
                    .foregroundColor(.gray)
        }
    
     }
   }
}

struct RatingView: View{
    var rating: Float
    var body: some View{
        
        HStack(spacing: 4){
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 12, height: 12)
                .foregroundColor(.orange)
            
            Text(String(format: "%.1f", rating))
                .fontWeight(.medium)
                            }
    }
}

struct MoviesListView: View {
    var movies: [Movie]
    @ObservedObject var viewModel: MovieViewModel
    var body: some View {
        List {
            ForEach(movies) { movie in
                NavigationLink (
                    destination: DetailsView(movie: movie, viewModel: viewModel),
                    label: {
                    MovieView(movie: movie)
                                  .padding(.vertical)
                                  .onAppear{
                                      viewModel.fetchDataIfNeeded(movie: movie)
                                  }
                })
              
              }
                
            }
       
        .listStyle(PlainListStyle())
        
        
    }
}


struct LoadingView: View{
    var body: some View{
        
        Text("Carregando Dados...")
            .foregroundColor(.gray)

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
