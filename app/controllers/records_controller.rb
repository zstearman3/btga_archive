class RecordsController < ApplicationController
  def index
    @records = Record.all.order(name)
  end
end
