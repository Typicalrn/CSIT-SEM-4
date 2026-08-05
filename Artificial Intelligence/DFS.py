graph={
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D':[],
    'E':['G'],
    'F':[],
    'G':[]
}

stack=['A']
visited=[]

goal='G'

while stack:
    node=stack.pop()
    print(f"Visited:{node}")
    if node not in visited:
        visited.append(node)
        
        if node== goal:
            break
        
        for neighbor in reversed(graph[node]):
            stack.append(neighbor)
            
        print(f"Stack: {stack}")
        print(f"Visited: {visited}")
        
print(visited)