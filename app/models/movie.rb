class Movie < ActiveRecord::Base

  # ================================================================
   def Movie.ratings
      #obtengo los rating distintos existentes en BDD
      movies = Movie.select "DISTINCT rating"
      ratings = []
      movies.each do |movie|
         ratings << movie.rating
      end
      return ratings
   end #ratings

  # ================================================================
   def Movie.rated_and_ordered (rat_selecc, ord)
      #obtengo las películas que contienen los rating pasados ordenadas
      w = ""
      if rat_selecc==nil then rat_selecc = {} end
      rat_selecc.keys.each do |rat|
         w += ("rating = '"+rat.to_s+"'")
         if (rat != rat_selecc.keys.last) then w += " or " end
      end #each
      Movie.where(w).order(ord)
   end #rated_and_ordered
   
   # ================================================================
   # ================================================================
end
