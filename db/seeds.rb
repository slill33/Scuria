# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
["first","second","third"].each do |i|
  team = Team.create!(
    name:"#{i}_seed_create_teem"
  )
  5.times do |n|
    team.users.create!(
      email: "#{i}_seed#{n}@example.com",
      name: "User#{n}",
      password: '111111',
      super: n==0 ? 1:0
    )
  end
  ["PRODUCT","SPRINT"].each do |type|
    BacklogType.create!(
      name:type,
      team_id:team.id
    )
  end
  backlog_types = BacklogType.last(2)
  3.times do |n|
    bl = team.backlogs.create!(
      name:"#{i}_seed_backlog#{n}",
      backlog_type_id: n==0 ? backlog_types[0].id : backlog_types[1].id
    )
    ["tag1","tag2","tag3"].each do |tag|
      bl.backlog_tags.create!(
        name:tag
      )
    end
    tags = BacklogTag.last(3)
    User.last(5).each_with_index do |user, index|
      if (n%2==0 && index%2==0) || (n%2==1 && index%2==1)
        UserToBacklog.create!(
          user_id:user.id,
          backlog_id:bl.id
        )
      end
    end
    ["TODO","DOING","DONE"].each_with_index do |x, index|
      col = BacklogColumn.create!(
        name:x,
        backlog_id:bl.id,
        position:index,
        color:"#000"
      )
      3.times do |priority|
        col.backlog_items.create!(
          backlog_id:bl.id,
          name:"#{x}#{priority}",
          priority:priority,
          description:"test#{priority}"
        )
      end
      BacklogItem.last(3).each_with_index do | item, index |
        tag_ids_array = [[0,1],[1,2],[0,1,2]]
        tag_ids_array[index].each do |tag_id|
          BacklogItemToBacklogTag.create!(
            backlog_item_id:item.id,
            backlog_tag_id:tags[tag_id].id
          )
        end
      end
    end
  end
end