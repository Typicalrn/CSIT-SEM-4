graph = {
'A': ['B', 'C'],
'B': ['D', 'E'],
'C': ['F'],
'D': [],
'E': ['G'],
'F': [],
'G': []
}
def dls(node, goal, limit, path):
    path.append(node)
    if node == goal:
        return True, path.copy()
    if limit == 0:
        path.pop()
        return False, []
    for child in graph[node]:
        found, result = dls(child, goal, limit - 1, path)
        if found:
            return True, result
    path.pop()
    return False, []
def iddfs(start, goal, max_depth):
    for depth in range(max_depth + 1):
        found, path = dls(start, goal, depth, [])
        if found:
            print("Found at depth:", depth)
            print("Path:", " -> ".join(path))
            return True
    print("Not found")
    return False
iddfs('A', 'G', 4)