class Tag < ActiveRecord::Base
	# order by creation
	default_scope :order => 'created_at DESC'
	#belongs_to :post
	has_many :post_tags
	has_many :posts, :through => :post_tags
end
