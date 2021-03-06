class Article < ApplicationRecord
    has_many :comments
    has_many :taggings
    has_many :tags, through: :taggings
    
    has_attached_file :image
    validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]
    
    def tag_list
        self.tags.collect do |tag|
            tag.name
        end.join(", ")
    end        

    def tag_list=(tag_string)
        tag_names = tag_string.split(",").collect{|s| s.strip.downcase}.uniq
        self.tags = tag_names.collect {|tag| Tag.find_or_create_by(name: tag)}
    end
end
