describe Movie do
describe 'Search movies by the same director' do
     it 'should call Movie.movies_by_same_director' do
      expect(Movie).to receive(:movies_by_same_director).with('Aladdin')
      get :search, { title: 'Aladdin' }
    end
     it 'should assign similar movies if director exists' do
      movies = ['Seven', 'The Social Network']
      Movie.stub(:movies_by_same_director).with('Seven').and_return(movies)
      get :search, { title: 'Seven' }
      expect(assigns(:movies_by_same_director)).to eql(movies)
    end
     it "should redirect to home page if director isn't known" do
      Movie.stub(:movies_by_same_director).with('No name').and_return(nil)
      get :search, { title: 'No name' }
      expect(response).to redirect_to(root_url) 
    end
  end
end