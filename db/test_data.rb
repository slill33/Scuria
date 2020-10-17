b1 = Backlog.find(1)
b2 = Backlog.find(2)
b3 = Backlog.find(3)

b1_columns = b1.backlog_columns
b2_columns = b2.backlog_columns
b3_columns = b3.backlog_columns


c2 = b1_columns.create(name: "B1_Before_column", position: 3, backlog_id: 1, color: "#FFF", parent_id: 0)
c3 = b1_columns.create(name: "B1_Aefore_column", position: 4, backlog_id: 1, color: "#8F8", parent_id: 0)

c5 = b2_columns.create(name: "B2_Before_column", position: 1, backlog_id: 1, color: "#FFF", parent_id: c2.id)
c6 = b2_columns.create(name: "B2_Aefore_column", position: 2, backlog_id: 1, color: "#8F8", parent_id: c3.id)

c8 = b3_columns.create(name: "B3_Before_column", position: 8, backlog_id: 3, color: "#FFF", parent_id: c5.id)
c9 = b3_columns.create(name: "B3_Aefore_column", position: 9, backlog_id: 3, color: "#8C8", parent_id: c6.id)


i1 = c8.backlog_items.create(name:"B1_item", priority: 0, description: '', backlog_id: 1, parent_id: 0)
i2 = c5.backlog_items.create(name:"B2_item", priority: 0, description: '', backlog_id: 2, parent_id: i1.id)
i3 = c2.backlog_items.create(name:"B3_item", priority: 0, description: '', backlog_id: 3, parent_id: i2.id)
