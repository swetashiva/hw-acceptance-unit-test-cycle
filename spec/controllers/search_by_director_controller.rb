require 'rails_helper'
describe MoviesController do
 
#using stubs to check controller action
describe 'Search movies by the same director' do
     it 'should call Movie.movies_by_same_director' do
      expect(Movie).to receive(:movies_by_same_director).with('Bharatam')
      get :search, { title: 'Bharatam' }
    end
     it 'should assign similar movies if director exists' do
      Movie.stub(:movies_by_same_director).with('My Dear Kuttichathan').and_return(['Pavithram', 'My Dear Kuttichathan'])
      get :search, { title: 'My Dear Kuttichathan' }
      expect(assigns(:movies_by_same_director)).to eql(['Pavithram', 'My Dear Kuttichathan'])
    end
     it "should redirect to home page if director isn't known" do
      Movie.stub(:movies_by_same_director).with('ZNMD').and_return(nil)
      get :search, { title: 'ZNMD' }
      expect(response).to redirect_to(movies_path) 
    end
    
 #to create new movies in db and search for directors without stubs
    it "should create new movies in db, search for movies with same director, check nil/blank movie director scenario, delete a movie, check the search for movies with same director " do

        #create new movies
        post :create, :movie => { :title => "Seetharamaiyah Gari Manavaralu", :rating => "G", :director => "", :release_date => "1/11/1991" }
        post :create, :movie => { :title => "Pavithram", :rating => "G", :director => "T K Rajeev Kumar", :release_date => "2/4/1994" }    
        post :create, :movie => { :title => "My Dear Kuttichathan", :rating => "PG", :director => "T K Rajeev Kumar", :release_date => "8/24/1984" }    
        
        # all the created movies exist
        expect(Movie.where(:title => "Seetharamaiyah Gari Manavaralu")).to exist
        expect(Movie.where(:title => "Pavithram")).to exist
        expect(Movie.where(:title => "My Dear Kuttichathan")).to exist
        
        #search for movies with same director
        expect(Movie.movies_by_same_director("Pavithram")).to eql(['Pavithram','My Dear Kuttichathan'])
        expect(Movie.movies_by_same_director("Pavithram")).to_not include(['Seetharamaiyah Gari Manavaralu'])
        expect(Movie.movies_by_same_director("Seetharamaiyah Gari Manavaralu")).to eql(nil)
        
        #delete a movie
        delete :destroy, :id => Movie.find_by_title("My Dear Kuttichathan")[:id]
         
        #check that the movie does not exist
        expect(Movie.find_by_title("My Dear Kuttichathan")).to eql(nil)
        
        #check that the movie does not appear in the search for movies with same director
        expect(Movie.movies_by_same_director("Pavithram")).to_not include(['My Dear Kuttichathan'])
      end 

  end
end