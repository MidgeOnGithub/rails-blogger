class Article < ApplicationRecord
    has_many :comments
    has_many :taggings
    has_many :tags, through: :taggings
    
    def tag_list=(tag_string)
        tag_names = tag_string.split(",").collect{|s| s.strip.downcase}.uniq
        self.tags = tag_names.collect {|tag| Tag.find_or_create_by(name: tag)}
    end
end
