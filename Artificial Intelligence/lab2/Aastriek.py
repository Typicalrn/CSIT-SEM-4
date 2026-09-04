from queue import PriorityQueue

def a_star(graph,heuristic,start,goal):
    pq=PriorityQueue()
    pq.put((0,start))
    
    g_cost={start:0}
    parent={start:None}
    
    while not pq.empty():
        f,current=pq.get()
        
        if current == goal:
            path=[]
            while current:
                path.append(current)
                current = parent[current]
            return path[::1],g_cost[goal]
        
        for neighbor, cost in graph[current]:
            new_g=g_cost[current] + cost
            
            if neighbor not in g_cost or new_g < g_cost[neighbor]:
                g_cost[neighbor]=new_g
                f_cost=new_g+heuristic[neighbor]
                pq.put((f_cost,neighbor))
                parent[neighbor]=current 
           
    return None

graph={
    'A':[('B',1),('C',4)],
    'B':[('D',2),('E',5)],
    'C':[('F',3)],
    'D':[],
    'E':[('G',1)],
    'F':[],
    'G':[]
}

heuristic={
    'A':6,
    'B':4,
    'C':3,
    'D':3,
    'E':1,
    'F':2,
    'G':0,
}


path,cost=a_star(graph,heuristic,'A','G')

print("Path:",path)
print("Total Cost:",cost)
