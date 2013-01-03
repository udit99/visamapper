class VotesController < ApplicationController

  def create
    citizenship_country_id = Country.find_by_country_code(params[:citizen_country]).id
    visa_country_code = params[:visa_country_code]
    visa_id = Visa.find_by_country_id_and_country_code(citizenship_country_id, visa_country_code).id
    vote = Vote.find_or_create_by_visa_id_and_user_id(visa_id,current_user.id)
    vote.vote_value = params[:vote]
    vote.save!

    render :nothing => true
  end

  def fb_comment
    @comment_url = "http://www.visamapper.com/comments/#{params[:citizen_country]}/#{params[:visa_country]}"
    render :layout => false
  end
end
