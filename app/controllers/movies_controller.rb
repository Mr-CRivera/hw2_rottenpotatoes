class MoviesController < ApplicationController

  # ================================================================
  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    if [nil,""].include?(@movie.description) then @movie.description = "-- No description --" end
  end


  # ================================================================
  def index
  
    #si no hay valores pasados como parametro, pero si en session, los restauro restful
    if params[:ratings]==nil and params[:format]==nil and (session[:ratings]!=nil or session[:format]!=nil)
      redirect_to movies_path(:ratings => session[:ratings], :format => session[:format])
      flash.keep
    end
    
    #si se ha ordenado, creo una variable que decora el orden en la vista
    if params[:format]!= nil 
      self.instance_variable_set ("@hilite_"+params[:format]).to_sym, "hilite"
    end
    
    #obtengo @all_ratings @rat_selecc y @movies de la url para representar en la vista
    @all_ratings = Movie.ratings
    if params[:ratings] == nil
      @rat_selecc = {}
      @all_ratings.each do |rat|
        @rat_selecc[rat] = 1
      end #each
    else
      @rat_selecc = params[:ratings]
    end #else
    @movies = Movie.rated_and_ordered params[:ratings], params[:format]
    
    #coloco en session los valores de format y ratings para recordarlos
    session[:ratings] = params[:ratings]
    session[:format] = params[:format]
    
    #debug
    #flash[:notice] = "#{session[:format].inspect}"+" || "+"#{session[:ratings].inspect}"

  end #index

  # ================================================================
  def new
    # default: render 'new' template
  end #new

  # ================================================================
  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end #create

  # ================================================================
  def edit
    @movie = Movie.find params[:id]
  end #edit

  # ================================================================
  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end #update

  # ================================================================
  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end #destroy

  # ================================================================
  # ================================================================
end #class
