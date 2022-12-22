# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do |i|
    u = User.create!(
        email: "user#{i+1}@email.com", 
        password: "password", 
        password_confirmation: "password",
        name: "User #{i+1}"
    )
end

4.times do |i|
    p = Project.create!(
        name: "Project #{i+1}",
        description: "Some random bs about this shit...",
        user_id: User.all.pluck(:id).sample
    )
end

20.times do |i|
    start_time = DateTime.now - Random.rand(8).hour 
    end_time = start_time + Random.rand(4).hour
    t = Task.create!(
        project_id: Project.all.pluck(:id).sample,
        user_id: User.all.pluck(:id).sample,
        name: "Task #{i+1}",
        description: "",
        status: ['not-started', 'in-progress', 'complete'].sample,
        start_time: start_time,
        end_time: end_time
    )
end
