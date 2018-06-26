require 'rest-client'
require 'json'
require 'pry'

def get_character_movies_from_api(character)
  #make the web request
  count = 1
  loop do
    # binding.pry
    all_characters = RestClient.get("https://swapi.co/api/people/?page=#{count}")
    character_hash = JSON.parse(all_characters)
    # binding.pry

    # iterate over the character hash to find the collection of `films` for the given
    #   `character`
    # collect those film API urls, make a web request to each URL to get the info
    #  for that film
    # return value of this method should be collection of info about each film.
    #  i.e. an array of hashes in which each hash reps a given film
    # this collection will be the argument given to `parse_character_movies`
    #  and that method will do some nice presentation stuff: puts out a list
    #  of movies by title. play around with puts out other info about a given film.
    # binding.pry
    use_hash = character_hash["results"].find do |hash|
      hash["name"].downcase == character
      # binding.pry
      # binding.pry
    end
    if use_hash
      collection = []
      use_hash["films"].each do |urls|
        movie_names = convert(urls)
        collection << movie_names
        # binding.pry
      end
      return collection
    elsif count > 9
      break
    end
    count += 1
  end
end

def convert(urls)
  url_link = RestClient.get(urls)
  JSON.parse(url_link)
end

def parse_character_movies(films_hash)
  # some iteration magic and puts out the movies in a nice list
  films_hash.each do |film|
    puts film["title"]
  end
end

def show_character_movies(character)
  films_hash = get_character_movies_from_api(character)
  parse_character_movies(films_hash)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
