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
      @project = @user.project.create(name: params[:name], materials: params[:materials], instructions: params[:instructions])
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
    if !authorized_to_edit?(@recipe)
      redirect to '/projetcs'
    end
    erb :"projects/edit"
  end
  
  patch '/projects/:id' do
    proecjt = Project.find(params[:id])
    if !authorized_to_edit?(@project)
      redirect to '/projects'
    end
    if params[:name].empty?
      redirect to "/projetcs/#{params[:id]}/edit"
    end
    project.update(name: params[:name], materials: params[:materials], instructions: params[:instructions])
 
    redirect to "/projetcs/#{project.id}"
  end

  delete '/projetcs/:id/delete' do 
    if !logged_in?
      redirect to '/login'
    end
    @project = Project.find(params[:id])
    if !authorized_to_edit?(@project)
      redirect to '/projetcs'
    else
      @project.delete
      redirect to '/projects'
    end 
  end 

end 