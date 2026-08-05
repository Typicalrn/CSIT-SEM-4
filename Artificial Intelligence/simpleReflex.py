# Simple Reflex Agent

rooms={
    'A':'Dirty',
    'B':'Dirty'
}

location='A'

for i in range(3):
    print("Current location: ",location)
    print("Room Status: ",rooms[location])

    if rooms[location]=='Dirty':
        action='Suck'
    elif location=='A':
        action='Move Right'
    elif location=='B':
        action='Move Left'
    
  
    print("Action: ",action)
    if action=='Suck':
        rooms[location]='Clean'
        print("Room Status: ",rooms[location])
    elif action=='Move Right':
        location='B'
    elif action=='Move Left':
        location='A'
    
    
print("Final Room Status: ",rooms)