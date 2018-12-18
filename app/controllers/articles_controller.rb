class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  
  def index 
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end
  
  def new
    @article = Article.new
  end
  
  def edit
    
  end
  
  def create
    
    @article = current_user.articles.create(article_params)
    if @article.save
      flash[:success] = "Articulo creado exitosamente"
      redirect_to article_path(@article)
    else 
      render 'new'
    end
  end
  
  def update 
    if @article.update(article_params)
      flash[:success] = "Articulo actualizado exitosamente"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
    @article = Article.find(params[:id])
  end
  
  def destroy
    
    @article = Article.find(params[:id])
    
    @article.destroy
    
    flash[:danger] = "Articulo borrado exitosamente"
    
    redirect_to articles_path
  end
  
  private
  
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
    params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
      if current_user != @article.user
        flash[:danger] = "Tu solo puedes editar o borrar tus propios articulos"
        redirect_to root_path
      end
    end
    
end 