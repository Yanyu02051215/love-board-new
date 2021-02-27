class BookmarksController < ApplicationController
  
  def create
    bookmark = Bookmark.create(user_id: current_user.id, question_id: params[:id])
  end

  def destroy
    bookmark = Bookmark.find_by(user_id: current_user.id, question_id: params[:id])
    bookmark.destroy
  end
end
