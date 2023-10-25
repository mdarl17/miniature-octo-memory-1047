require "rails_helper"

RSpec.describe "Project Show Page", type: :feature do 
  it "should show project's name and material when visiting show page" do
    challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    project = challenge.projects.create(name: "News Chic", material: "Newspaper")

    visit "/projects/#{project.id}"

    expect(page).to have_content("Project: News Chic")
    expect(page).to have_content("Newspaper")
  
  end
  it "should show the theme when visiting project show page" do
    challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    project = challenge.projects.create(name: "News Chic", material: "Newspaper")

    visit "/projects/#{project.id}"

    expect(page).to have_content("Recycled Material")
  end

  it "displays the number of contestants working on a project" do
    challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    project = challenge.projects.create(name: "News Chic", material: "Newspaper")

    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

    ContestantProject.create(contestant_id: jay.id, project_id: project.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: project.id)

    visit "/projects/#{project.id}"

    expect(page).to have_content("Number of Contestants: 2")
  end

  it "displays the average age of each contestant working on the project" do

    challenge = Challenge.create(theme: "Recycled Material", project_budget: 1000)
    project = challenge.projects.create(name: "News Chic", material: "Newspaper")

    jay = Contestant.create(name: "Jay McCarroll", age: 40, hometown: "LA", years_of_experience: 13)
    gretchen = Contestant.create(name: "Gretchen Jones", age: 36, hometown: "NYC", years_of_experience: 12)

    ContestantProject.create(contestant_id: jay.id, project_id: project.id)
    ContestantProject.create(contestant_id: gretchen.id, project_id: project.id)
    
    visit "/projects/#{project.id}"

    expect(page).to have_content(38.0)

    save_and_open_page
  end
end