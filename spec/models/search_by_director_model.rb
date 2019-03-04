require 'rails_helper'
describe Movie do
  describe '.find_movies_by_same_director' do
   # how to create these fixtures?
   # title: "Seetharamaiyah Gari Manavaralu", director: "Kranthi Kumar", release_date: "1/11/1991" 
   # title: "Pavithram", director: "T K Rajeev Kumar", release_date: "2/4/1994" 
   # title: "My Dear Kuttichathan", director: "T K Rajeev Kumar", release_date: "8/24/1984" 
     context 'director exists' do
      it 'handles happy path' do
        expect(Movie.movies_by_same_director("Pavithram")).to eql(['My Dear Kuttichathan'])
        expect(Movie.movies_by_same_director("Pavithram")).to_not include(['Seetharamaiyah Gari Manavaralu'])
      end
    end
     context 'director does not exist' do
      it 'handles sad path' do
        expect(Movie.movies_by_same_director("Seetharamaiyah Gari Manavaralu")).to eql(nil)
      end
    end
  end
end
