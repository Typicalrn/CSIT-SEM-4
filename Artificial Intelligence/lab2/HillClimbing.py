def hill_climbing(graph,heuristic,start,goal):
    current=start
    path=[current]
    
    while current!=goal:
        neighbors=graph[current]
        
        if not neighbors:
            break
        
        best_neighbors=min(
            neighbors,
            key=lambda x: heuristic[x]
        )
        
        if heuristic[best_neighbors]>= heuristic[current]:
            print("Reached local optimum")
            break
            
        current=best_neighbors
        path.append(current)
    return path

graph={
    'A':['B','C'],
    'B':['D','E'],
    'C':['F'],
    'D':[],
    'E':['G'],
    'F':[],
    'G':[]
}

heuristic={
    'A':6,
    'B':4,
    'C':5,
    'D':3,
    'E':2,
    'F':4,
    'G':0
}

path=hill_climbing(graph,heuristic,'A','G')

print("Path:", path)