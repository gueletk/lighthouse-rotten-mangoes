class Movie < ActiveRecord::Base

  scope :title, -> (title) { where("title like ?", "%#{title}%")}
  scope :shorter_than, -> (runtime_in_minutes) { where("runtime_in_minutes < ?", runtime_in_minutes) }
  scope :longer_than_or_equal_to, -> (runtime_in_minutes) { where("runtime_in_minutes >= ?", runtime_in_minutes) }
  scope :director, -> (director) { where("director like ?", "%#{director}%") }

  has_many :reviews
  mount_uploader :poster, PosterUploader
  validates :title,
      presence: true

  validates :director,
    presence: true

  validates :runtime_in_minutes,
    numericality: { only_integer: true }

  validates :description,
    presence: true

  # validates :poster_image_url,
  #   presence: true

  validates :release_date,
    presence: true

  validate :release_date_is_in_the_past

  def self.search(search)
    @movies = Movie.all
    case search[:time_range]
    when "1"
      @movies = @movies.shorter_than(90)
    when "2"
      @movies = @movies.shorter_than(120).longer_than_or_equal_to(90)
    when "3"
      @movies = @movies.longer_than_or_equal_to(120)
    end

    if search[:title]
      @movies = @movies.title(search[:title])
    end

    if search[:director]
      @movies = @movies.director(search[:director])
    end
    @movies
  end

  protected

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end

  def review_average
    reviews.size > 0 ? reviews.sum(:rating_out_of_ten)/reviews.size : 0
  end

end
