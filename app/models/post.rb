class Post < ActiveRecord::Base
	attr_accessible :content, :name, :title, :tags_attributes

	validates :name,  :presence => true
	validates :title, :presence => true,
	                  :length   =>{ :minimum =>5 }
	has_many :comments, :dependent => :destroy
	has_many :post_tags, :dependent => :destroy
	has_many :tags, :through => :post_tags, :class_name => "Tag"
	#has_many :tags #实际上对于标签来说应该是一个多对多的关联, 为了方便教程我在这里使用一对多关系  
           
  	accepts_nested_attributes_for :tags, :allow_destroy => :true,
    :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
