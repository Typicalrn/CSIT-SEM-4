# Model-Based Agent
rooms={
    'A':'dirty',
    'B':'dirty'
}

model={
    'A':'Unknown',
    'B':'Unknown'  
}
location='A'
status=rooms[location]
model[location]=status

print("Model Memory: ",model)
print("Current Location: ",location)
print("Room Status: ",rooms[location])

if status=='dirty':
    action='Suck'

if model['A']=='clean' and model['B']=='clean':
    action='No Action'
elif status=='dirty':
    action='Suck'
elif location=='A':
    action='Move Right'
elif location=='B':
    action='Move Left'

print("Action: ",action)

if action=='Suck':
    rooms[location]='clean'
    model[location]='clean'
    print("Room Status: ",rooms[location])
elif action=='Move Right':
    location='B'
elif action=='Move Left':
    location='A'