require "rails_helper"

RSpec.describe Contestant, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :hometown}
    it {should validate_presence_of :years_of_experience}
  end

  describe "relationships" do
    it {should have_many :contestant_projects}
    it {should have_many(:projects).through(:contestant_projects)}
  end

  describe "instance variables" do
    describe "#project_list" do
      it "should return a sentence with all of the projects the contestant has worked on" do
        recycled_material_challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        furniture_challenge = Challenge.create(theme: "Apartment Furnishings", project_budget: 1000)

        news_chic = recycled_material_challenge.projects.create(name: "News Chic", material: "Newspaper")
        upholstery_tux = furniture_challenge.projects.create(name: "Upholstery Tuxedo", material: "Couch")
        boardfit = recycled_material_challenge.projects.create(name: "Boardfit", material: "Cardboard Boxes")

        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)
        kentaro = Contestant.create(name: "Kentaro Kameyama", age: 30, hometown: "Boston", years_of_experience: 8)

        ContestantProject.create(contestant_id: gretchen.id, project_id: news_chic.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: upholstery_tux.id)
        ContestantProject.create(contestant_id: kentaro.id, project_id: boardfit.id)

        expect(gretchen.project_list).to eq("News Chic and Upholstery Tuxedo")
        expect(kentaro.project_list).to eq("Upholstery Tuxedo and Boardfit")
      end
    end
  end
end
