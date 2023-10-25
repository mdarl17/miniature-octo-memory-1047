require "rails_helper"

RSpec.describe Project, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :material}
  end

  describe "relationships" do
    it {should belong_to :challenge}
    it {should have_many :contestant_projects}
    it {should have_many(:contestants).through(:contestant_projects)}
  end

  describe "instance variables" do
    describe "#contestant_count" do
      it "returns the number of contestants working on a project" do
        challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        project = challenge.projects.create(name: "News Chic", material: "Newspaper")

        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

        ContestantProject.create(contestant_id: jay.id, project_id: project.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: project.id)

        expect(project.contestant_count).to eq(2)
      end
    end

    describe "#average_years_experience" do
      it 'calculates the average age of all the members on a project' do
        challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
        project = challenge.projects.create(name: "News Chic", material: "Newspaper")

        jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
        gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

        ContestantProject.create(contestant_id: jay.id, project_id: project.id)
        ContestantProject.create(contestant_id: gretchen.id, project_id: project.id)
        
        expect(project.average_years_experience).to eq(38.0)
      end
    end
  end
end
