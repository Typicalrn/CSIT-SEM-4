#to show greedy best first search
from queue import PriorityQueue

def greedy_BFS(graph, heuristic,start, goal):
    pq= PriorityQueue()
    pq.put((heuristic[start],start))
    visited= set()
    parent={ start:None}
    
    while not pq.empty():
        h,current = pq.get()
        
        if current == goal:
            path=[]
            while current:
                path.append(current)
                current = parent[current]
            return path[::1]
        if current not in visited:
            visited.add(current)
            
            for neighbor in graph[current]:
                if neighbor not in visited:
                    parent[neighbor]=current
                    pq.put((heuristic[neighbor],neighbor))
    return None

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
    'C':3,
    'D':5,
    'E':2,
    'F':4,
    'G':0
}

path=greedy_BFS(graph, heuristic,'A','G')
print("Path:",path)