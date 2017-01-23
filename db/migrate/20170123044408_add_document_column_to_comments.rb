class AddDocumentColumnToComments < ActiveRecord::Migration
  def change
    add_attachment :comments, :document
  end
end
