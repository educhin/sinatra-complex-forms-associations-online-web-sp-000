class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index'
  end

  get '/pets/new' do
    @owners = Owner.all
    erb :'/pets/new'
  end

  post '/pets' do
    @pet = Pet.create(params[:pet])
    if !params["owner"]["name"].empty?
      @owner = Owner.create(params["owner"])
      @owner.save
      @pet.owner_id = @owner.id
      @pet.save
    end

    @pet.save

    redirect to "pets/#{@pet.id}"
  end

  get '/pets/:id' do
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end

  get '/pets/:id/edit' do
    @pet = Pet.find(params[:id])
    @owners = Owner.all
    erb :'/pets/edit'
  end

  patch '/pets/:id' do
    binding.pry
    @pet = Pet.find(params[:id])

    if !params["pet"]["name"].empty?
      @pet.name = params["pet"]["name"]
      @pet.save
    end

    if !params["owner"]["name"].empty?
      @owner = Owner.create(params["owner"])
      @owner.save
      @pet.owner_id = @owner.id
      @pet.save
    end
    redirect to "pets/#{@pet.id}"
  end
end
