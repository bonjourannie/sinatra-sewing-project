class ProjectsController < ApplicationController

get "/project" do
  @project = Project.all
  erb :"/project/index"
end

get "/project/new" do
  redirect_if_not_logged_in?
  @project = Project.all
  erb :"/project/new"
end

post "/project" do
  @project = Project.new
  @project.name = params[:name]
  @project.materials = params[:materials]
  @project.instructions = params[:instructions]
 # current_user.project.new(name: params[:project][:name], materials: params[:project][:materials], instructions: params[:project][:instructions])
  if !params[:project][:name].empty? && !params[:project][:materials].empty? && !params[:project][:instructions].empty?
      @project.save
      flash[:message] = "You successfully created a new sewing project"
      redirect ("/project/#{@project.slug}")
  else
      flash[:message] = "Please fill in all the fields"
      redirect to "/project/new"
  end
end

get "/project/:id" do
  redirect_if_not_logged_in?
  @project = Project.find_by_id(params[:id])
  erb :"/project/show"
end

get "/project/:id/edit" do
  redirect_if_not_logged_in?
  @project = current_user.project.find_by_id(params[:id])
  if @project
      erb :"/project/edit"
  else 
      redirect to '/project/new'
  end
end

patch '/project/:id' do 
  @project = current_user.project.find_by_id(params[:id])
  if @project
      @project.update(name: params[:project][:name], materials: params[:project][:materials], instructions: params[:project][:instructions])
      flash[:message] = "Project successfully updated!"
      redirect to "/project/#{@project.id}"
  else 
      flash[:message] = "Sorry, project not found"
      erb :'project/edit.html'
  end
end

delete '/project/:id' do 
  @project = Project.find_by_id(params[:id])
  redirect '/project/new' unless @project
  @project.update(deleted: true)
  redirect to '/project/new'
end

end