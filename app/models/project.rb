class Project < ActiveRecord::Base

    belongs_to :user
    has_many :materials

    def material_names=(material_names)
        puts material_names
        
        #binding.pry
        material_names.delete_if{|hash| hash["name"]==""}
        self.materials.build(material_names)
    end


    def slug
      name.downcase.delete(?').gsub(" ","-").gsub("’","")
    end
  
    def self.find_by_slug(slug)
      self.all.find{|project| project.slug == slug}
    end
  
  end