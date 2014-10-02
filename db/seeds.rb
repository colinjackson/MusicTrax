# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

[
  { email: "smokey@bear.com", password: "forestfirez" },
  { email: "anna@molly.org", password: "incubutts" },
  { email: "london@bridge.co.uk", password: "ukbaby" }
].each { |params| User.create!(params) }


band = Band.create!(name: "Kelis")
album = band.albums.create!(name: "The Milkshake Album")
track1 = album.tracks.create!(name: "Milkshake")
track2 = album.tracks.create!(name: "A General Theory of Relativity")
