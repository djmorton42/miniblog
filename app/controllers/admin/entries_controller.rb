class Admin::EntriesController < Admin::AdminAreaController
  def index
    @entries = Entry.all
  end

  def edit

  end

  def new

  end
end
