#!/bin/bash

# Part 1.2 Q4
# https://docs.mongodb.com/v3.0/tutorial/create-an-auto-incrementing-field/

# Function that generates an auto-incrementing sequence field
# Counter collection to track the last number sequence used
# getNextSequence to automatically increment the seq value and return this new value
# Then ultimately inserting it into our collection

input="fully_cleaned.csv"

sed 1d $input | while IFS="," read -r -a var

do

mongo 127.0.0.1/PeopleData --eval '

db.counters.insert(
   {
      _id: "userid",
      seq: 0
   }
)

function getNextSequence(name) {
   var ret = db.counters.findAndModify(
          {
            query: { _id: name },
            update: { $inc: { seq: 1 } },
            new: true
          }
   );

return ret.seq;
}

db.newDB.insert(
   {
     	_id: getNextSequence("userid"),
     	INDEX: "'"${var[0]}"'",
	Name: "'"${var[1]}"'", 
	Age: "'"${var[2]}"'", 
	Country: "'"${var[3]}"'", 
	Height: "'"${var[4]}"'", 
	Hair_Colour: "'"${var[5]}"'"
   }
)
'
done





