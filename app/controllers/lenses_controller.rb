class LensesController < ApplicationController
    def index
        @lens = Lens.new
    end
end
