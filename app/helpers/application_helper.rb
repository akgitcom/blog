module ApplicationHelper

	class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer
	def prepare(collection, options, template)
		@remote = options.delete(:remote) || { }
			super
		end

		def link(text, target, attributes = {})
		    if target.is_a? Fixnum
		          attributes[:rel] = rel_value(target)
		          target = url(target)
		    end
		    attributes[:href] = target
		   # page_attr = { :page => target }
		   @template.link_to( text.to_s.html_safe, target, :remote => true )
		end
	end

end
