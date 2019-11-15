class Project < ActiveRecord::Base

    belongs_to :user
    has_many :materials

    validates :name, presence: true
    validates :intructions, presence: true

    def material_names=(material_names)
      puts material_names
        
      #binding.pry
      material_names.delete_if{|hash| hash["name"]==""}
      self.materials.clear
      self.materials.build(material_names)
    end

    def material_names
      materials.map {|material| material.name }
        
      # try to make a getter method 
      #that returns an array of the materials currently 
      #associated with the project and use that to fill in the values of the inputs
    end



    def slug
      name.downcase.delete(?').gsub(" ","-").gsub("’","")
    end
  
    def self.find_by_slug(slug)
      self.all.find{|project| project.slug == slug}
    end
  
  end