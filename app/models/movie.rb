class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def self.movies_by_same_director movie_title
    movie = Movie.find_by(title: movie_title)
    director = movie.director
    return nil if director.nil? || (director == "")
    Movie.where(director: director).pluck(:title)
  end
  
end
