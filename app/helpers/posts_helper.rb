module PostsHelper
	def join_tags(post)
		post.tags.map { |t| t.name }.join(", ")
	end

	def tags_used
		self.tags.collect(&:name).join(',')
	end	

	def tags_used=(list)
		self.tags = list.present? ? Tag.where(:name => list.split(/\s*,\s*/)) : [ ]
	end
	def tag_list=(tags)
	  self.tags.clear  # clears all the relations
	  tags.split(',').each do |tag|
	    self.tags << Tag.find_by_title(tag)  # and assigns once again
	  end
	end

	def tags_list
	  self.tags.collect do |tag|
	    tag.name
	  end.join(',')
	end
	def tags_list(tag)
	  tag.collect do |tag|
	    tag.name
	  end.join(',')
	end
end
