graph={
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D':[],
    'E':['G'],
    'F':[],
    'G':[]
}

visited_order=[]

def dls(node,goal,limit,path):
    visited_order.append(node)
    path.append(node)
    
    
    if node==goal:
        return True,path.copy()
    
    if limit<=0:
        path.pop()
        return False,[]
    
    for neighbor in graph[node]:
        found,result = dls(neighbor, goal,limit -1 ,path)
        
        if found:
            return True,result
        
    path.pop()
    return False,[]

found,path= dls('A','G',3,[])
if found:
    print("Goal found")
    print("Visited path","->".join(visited_order))
    print("Solution Path:","->".join(path))
else:
    print("Goal not found!")