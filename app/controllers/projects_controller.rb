class ProjectsController < ApplicationController

  get '/projects' do
    if !logged_in?
      redirect to '/login'
    end
    @user = current_user
    @projects = @user.projects 
    erb :"/projects/projects"
  end

get '/projects/new' do
    if !logged_in?
      redirect to '/login'
    end
    erb :"/projects/new"
    end
    
  post '/projects' do 
    @user = current_user
    if params[:name].empty?
      redirect to '/projects/new'
    end
      @project = @user.projects.create(name: params[:name], material_names: params[:material_names], instructions: params[:instructions])
    redirect to '/projects'
  end 
  
  get '/projects/:id' do
    if !logged_in?
      redirect to '/login'
    end
    @project = Project.find(params[:id])
    erb :"projects/show"
  end
  
  get '/projects/:id/edit' do
    if !logged_in?
      redirect to '/login'
    end
    @project = Project.find(params[:id])
    erb :"projects/edit"
  end
  
  patch '/projects/:id' do
    project = Project.find(params[:id])
    if !logged_in?
      redirect to '/login'
    end
    if params[:name].empty?
      redirect to "/projects/#{params[:id]}/edit"
    end
    project.update(name: params[:name], material_names: params[:material_names], instructions: params[:instructions])
 
    redirect to "/projects/#{project.id}"
  end

  delete '/projects/:id/delete' do 
    if !logged_in?
      redirect to '/login'
    end
    @project = Project.find(params[:id])
        @project.delete
      redirect to '/projects'
    
  end 

end 