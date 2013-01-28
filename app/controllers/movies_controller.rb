class MoviesController < ApplicationController

  @first = true

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end




  def index
    if params[:format]!= nil 
      self.instance_variable_set ("@hilite_"+params[:format]).to_sym, "hilite"
    end
    
    @all_ratings = Movie.ratings
    if @first then 
       @rat_selecc = {}
       @all_ratings.each do |rat|
         @rat_selecc[rat] = 1
       end
       @first = false
    else
       @rat_selecc = params[:ratings]
    end
    @movies = Movie.rated_and_ordered params[:ratings], params[:format]

    flash[:notice] = @rat_selecc
  end




  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
