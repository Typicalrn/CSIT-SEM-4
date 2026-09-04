graph = {
 0:[1,2,3],
 1:[0,2],
 2:[0,1,3],
 3:[0,2]
}
colors = ["Red","Green","Blue"]
result = {}
def is_safe(node, color):
    for neighbor in graph[node]:
        if neighbor in result and result[neighbor] == color:
            return False
    return True
def solve(node):
    if node == len(graph):
        return True
    for color in colors:
        if is_safe(node, color):
            result[node] = color
            if solve(node+1):
                return True
            del result[node]
    return False
if solve(0):
    print(result)
else:
    print("No Solution")