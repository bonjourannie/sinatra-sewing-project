class ProjectsController < ApplicationController

get "/projects" do
  @project = Projects.all
  erb :"/projects/index"
end

get "/projects/new" do
  redirect_if_not_logged_in?
  @projects = Projects.all
  erb :"/projects/new"
end

post "/projects" do
  @project = current_user.project.new(name: params[:project][:name], materials: params[:project][:materials], instructions: params[:project][:instructions])
  if !params[:project][:name].empty? && !params[:project][:materials].empty? && !params[:project][:instructions].empty?
      @project.save
      @project
      flash[:message] = "You successfully created a new sewing project"
      redirect ("/projects/#{@project.id}")
  else
      flash[:message] = "Please fill in all the fields"
      redirect to "/projects/new"
  end
end

get "/projects/:id" do
  redirect_if_not_logged_in?
  @project = Projects.find_by_id(params[:id])
  erb :"/projects/show"
end

get "/projects/:id/edit" do
  redirect_if_not_logged_in?
  @project = current_user.projects.find_by_id(params[:id])
  if @project
      erb :"/projects/edit"
  else 
      redirect to '/projects/new'
  end
end

patch '/projects/:id' do 
  @project = current_user.projects.find_by_id(params[:id])
  if @project
      @project.update(name: params[:project][:name], materials: params[:project][:materials], instructions: params[:project][:instructions])
      flash[:message] = "Project successfully updated!"
      redirect to "/projects/#{@project.id}"
  else 
      flash[:message] = "Sorry, project not found"
      erb :'projects/edit.html'
  end
end

delete '/projects/:id' do 
  @project = Projects.find_by_id(params[:id])
  redirect '/projects/new' unless @project
  @project.update(deleted: true)
  redirect to '/projects/new'
end

end