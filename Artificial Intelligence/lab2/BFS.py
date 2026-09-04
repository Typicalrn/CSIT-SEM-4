from collections import deque

graph = {
    'A': ['B', 'C'],
    'B': ['D', 'E'],
    'C': ['F'],
    'D': [],
    'E': ['G'],
    'F': [],
    'G': []
}

def bfs(start, goal):
    queue = deque([start])
    visited = set()
    
    while queue:
        node= queue.popleft()
        
        print(f"Visiting:{node}")
        
        if node== goal:
            print("Goal found!")
            return 
        
        visited.add(node)
        
        for neighbor in graph[node]:
            if neighbor not in visited :
                queue.append(neighbor)
                
        print(f"Queue: {list(queue)}")
        print(f"Visited: {visited}")
        
bfs('A','G')
