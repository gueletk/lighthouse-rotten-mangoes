class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
    if params[:search]
      @movies = Movie.search(params[:search])
    else
    # params[:movie][:title] = nil if params[:movie] != "" && params[:movie][:title] == ""
    # params[:movie][:director] = nil if params[:movie] != "" && params[:movie][:director] == ""
    #
    # if params[:movie] != ""

#    end
      @movies = Movie.all
    end
    # if params[:time_range]
    #   case params[:time_range]
    #   when "1"
    #     @movies = Movie.all.title(params[:movie][:title]).director(params[:movie][:director]).shorter_than(90)
    #   when "2"
    #     @movies = Movie.all.title(params[:movie][:title]).director(params[:movie][:director]).shorter_than(120).longer_than_or_equal_to(90)
    #   when "3"
    #     @movies = Movie.all.title(params[:movie][:title]).director(params[:movie][:director]).longer_than_or_equal_to(120)
    #   else
    #     @movies = Movie.all
    #   end
    # end
  end


  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :director, :runtime_in_minutes, :description, :poster_image_url, :release_date, :poster)
    end
end
