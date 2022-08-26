# frozen_string_literal: true

def create_object(klass, attributes, _attempt = 1)
  obj = klass.new(attributes)
  obj.save!
  obj
rescue StandardError => e
  puts "[User ERROR] #{e.post}"
  puts obj.attributes
end

# ---------------------------------------- | User

# Create admin user with known email and password
create_object(User, email: 'admin@example.com', password: 'password', name: Faker::Name.name)

9.times do
  create_object(User, email: Faker::Internet.email, password: 'password', name: Faker::Name.name)
end

users = User.all

# ---------------------------------------- | Post

random_dates = Array.new(100) { (2.weeks.seconds + rand(3.months).seconds).ago }.sort

random_dates.each do |date|
  # Mock the current time
  Timecop.freeze(date)
  # Set the user for the post as whodunnit for the version
  user = users.sample
  PaperTrail.request.whodunnit = user.id
  # Get an image URL
  random_image_url = URI('https://picsum.photos/1440/600')
  image_url = Net::HTTP.get_response(random_image_url)['location']
  # Create the post
  post = create_object(Post, title: Faker::Hipster.sentence,
                             body: Faker::Lorem.paragraphs(number: rand(2..6)).join("\n\n"),
                             published_at: Time.now + rand(10.days).seconds,
                             image_url:,
                             user:)
  # Build a few versions for the post
  rand(1..10).times do
    Timecop.freeze(Time.now + rand(1.day).seconds)
    PaperTrail.request.whodunnit = users.sample.id
    post.update(body: Faker::Lorem.paragraphs(number: rand(2..6)).join("\n\n"))
  end
  # Create a few versions.
  # Unset the mocks
  Timecop.return
  PaperTrail.request.whodunnit = nil
end
