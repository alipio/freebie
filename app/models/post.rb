require 'textacular'

class Post < ActiveRecord::Base.extend(Textacular)
  belongs_to :user
  has_many :post_items
  validates :status, inclusion: { in: %w(drafted published closed) }
  has_one :category_link, as: :item
  has_one :category, through: :category_link, source: :category

  has_attached_file :main_image, styles: {medium: "300x300>", thumb: "100x100>"}
  validates_attachment_content_type :main_image, content_type: /\Aimage\/.*\Z/

  def self.published_posts
    Post.where('status = ?', 'published')
  end

  def main_image_url
    self.image_url.present? ? self.image_url : self.main_image.url
  end

  def published?
    self.status == 'published'
  end

  def closed?
    self.status == 'closed'
  end

  def drafted?
    self.status == 'drafted'
  end

  def publish
    self.status = 'published' unless self.status == 'published'
  end

  def close
    self.status = 'closed' unless self.status == 'closed'
  end

  def self.search(query)
  	posts = published_posts
  	posts.basic_search(query)
  end

  def Post.find_by_categories category_ids
    # post_relations = CategoryLink.select(:item_id).distinct.where(category: category_ids, item_type: 'Post')
    posts = []
    category_ids.each do |id|
      Category.find(id).posts.each do |post|
        posts << post
      end
    end
    posts
  end

end
