GRID_SIZE=5

agent=(0,0)

goal=(4,4)

def is_goal(pos):
    return pos == goal

def choose_action(pos):
    x,y=pos
    gx,gy=goal
    if x<gx:
        return 'down'
    elif x>gx:
        return 'up'
    elif y<gy:
        return 'right'
    elif y>gy:
        return 'left'
    
def move(pos,action):
    x,y=pos
    if action=='up' and x>0:
        return (x-1,y)
    elif action=='down' and x<GRID_SIZE-1:
        return (x+1,y)
    elif action=='left' and y>0:
        return (x,y-1)
    elif action=='right' and y<GRID_SIZE-1:
        return (x,y+1)

def grid(pos):
    for i in range(GRID_SIZE):
        for j in range(GRID_SIZE):
            if (i,j)==pos:
                print("A",end=" ")
            elif (i,j)==goal:
                print("G",end=" ")
            else:
                print(".",end=" ")
        print()
    print()
    

def main():
    step=0
    pos=agent
    grid(pos)
    while not is_goal(pos):
        action=choose_action(pos)
        pos=move(pos,action)
        step += 1
        grid(pos)
    print("Goal Reached!")
    print(f"Steps taken: {step}")

main()