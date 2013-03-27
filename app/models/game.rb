class Game < ActiveRecord::Base
  attr_accessible :name, :deck, :description, :date_added, :original_release_date, :icon_url, :medium_url, :screen_url, :small_url, :super_url, :thumb_url, :tiny_url

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_many :events

  PLATFORMS = {
    'Xbox' => 20,
    'PS3'  => 88,
    'PC'   => 94 }

  def hashtag
    return "##{name.gsub(/\W/,'')}" if read_attribute(:hashtag).blank?
    "##{super.gsub(/\W/,'')}"
  end
end