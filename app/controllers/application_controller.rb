
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :session
    set :secret, 'password'
  end

  get '/articles' do
    @articles = Article.all
    erb :index
  end

  get '/articles/new' do
    erb :new
  end

  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    #binding.pry
    redirect "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article =  Article.find_by(id: params[:id])

    erb :show
  end

  get '/articles/:id/edit' do
    @article =  Article.find_by(id: params[:id])
    session[:article] = @article
    erb :edit
  end

  patch "/articles/:id" do
    #binding.pry
    
    session[:article].content = params[:content]
    session[:article].title = params[:title]
    session[:article].save

    redirect "/articles/#{session[:article].id}"
  end

  delete "/articles/:id" do
    @article =  Article.find_by(id: params[:id])
    @article.delete

    redirect '/articles'
  end


end
