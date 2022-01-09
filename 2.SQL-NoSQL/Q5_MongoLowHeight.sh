#!/bin/bash

# Part 1.2 Q5
# Script to return the name and height of the person with the lowest value for height


mongo 127.0.0.1/PeopleData --eval '
db.newDB.find({}, {Name:1, Height:1, _id:0}).sort({Height: 1}).limit(1)
'
