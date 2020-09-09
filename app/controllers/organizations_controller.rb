class OrganizationsController < ApplicationController
  before_action :authorize
  def index
    @organizations = Organization.filter_by_name(search_params).order(name: :asc)
  end

  def show
    @organization = Organization.find(params[:id])
  end

  private

  def search_params
    return '' if params[:organization].nil?
    params[:organization][:name]
  end

end
