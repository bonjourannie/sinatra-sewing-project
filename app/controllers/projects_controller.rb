class ProjectsController < ApplicationController

    get '/projects' do
      @error_message = params[:error]
      @project = Projects.all
      erb :'/projects/show'
    end
  
    get '/projects/new' do
      if logged_in?
        @error_message = params[:error]
        erb :'/projects/new'
      else
        redirect("/login")
      end
    end
  
    get '/projects/:slug/edit' do
      if logged_in?
        @project = Projects.find_by_slug(params[:slug])
        if @project.user_id == current_user.id
          erb :'/projetcs/edit'
        else
          redirect("/projects?error=You cannot edit a project that is not your own")
        end
      else
        redirect("/login?error=Not logged in")
      end
    end
  
    get '/projects/:slug' do
      if logged_in?
        @projects = Projects.find_by_slug(params[:slug])
        erb :'/projects/show'
      else
        redirect("/login?error=Please log in to see project details")
      end
    end
  
    post '/projects' do
      if logged_in?
        if current_user.projects.find_by(name: params[:project][:name])
          redirect("/projects/new?error=This project already exists")
        end
  
        if params[:project][:name] != "" && params[:project][:materials] != ""
        @project = Projects.create(params["project"])
        @project.user_id = current_user.id
        @project.save
  
        redirect("/projects/#{@project.slug}")
  
        else
          redirect("/projects/new?error=Both Name and Materials are required")
        end
  
      else
        redirect("/login")
      end
    end
  
    patch '/projects/:slug' do
      @project = Project.find_by_slug(params[:slug])
      if current_user.id == @project.user_id
        params[:project][:user_ids] ||= false
        @project.update(params[:project])
  
        redirect("/projects/#{@project.slug}")
      else
        redirect("/projects")
      end
    end
  
    delete '/projects/:slug/delete' do
      if logged_in?
      @project = Projects.find_by_slug(params[:slug])
        if @project.user_id == current_user.id
          @oriject.delete
          redirect("/projects")
        else
          redirect("/projects?error=You cannot delete a project that is not your own")
        end
      else
        redirect("/login")
      end
    end
  end