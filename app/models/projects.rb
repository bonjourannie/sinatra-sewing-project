class Projects < ActiveRecord::Base

    belongs_to :user
    has_many :materials

    def slug
      name.downcase.delete(?').gsub(" ","-").gsub("’","")
    end
  
    def self.find_by_slug(slug)
      self.all.find{|project| project.slug == slug}
    end
  
  end