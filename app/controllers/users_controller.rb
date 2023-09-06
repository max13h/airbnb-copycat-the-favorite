class UsersController < ApplicationController
  def lenses
    @lenses = Lens.where(user: current_user)
  end
end
