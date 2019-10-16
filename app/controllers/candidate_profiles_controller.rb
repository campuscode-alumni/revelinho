class CandidateProfilesController < ApplicationController
  before_action :set_candidate_profile, only: %i[edit update]
  before_action :authenticate_candidate!, only: %i[new create edit update]

  def new
    @candidate_profile = CandidateProfile.new
  end

  def create
    @candidate_profile = CandidateProfile.new(candidate_profile_params)
    @candidate_profile.candidate = current_candidate
    if @candidate_profile.save
      @candidate_profile.candidate.published!
      redirect_to @candidate_profile.candidate,
                  notice: 'Seu perfil foi atualizado com sucesso.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @candidate_profile.update(candidate_profile_params)
      redirect_to @candidate_profile.candidate.candidate,
                  notice: 'Seu perfil foi atualizado com sucesso.'
    else
      render :edit
    end
  end

  private

  def set_candidate_profile
    @candidate_profile = CandidateProfile.find(params[:id])
  end

  def candidate_profile_params
    params.require(:candidate_profile).permit(:work_experience,
                                              :education,
                                              :skills,
                                              :coding_languages,
                                              :english_proficiency,
                                              :skype_username,
                                              :linkedin_profile_url,
                                              :github_profile_url)
  end
end
