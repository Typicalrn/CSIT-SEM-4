from collections import deque

graph = {
'A': ['B', 'C'],
'B': ['A', 'D', 'E'],
'C': ['A', 'F'],
'D': ['B'],
'E': ['B', 'G'],
'F': ['C'],
'G': ['E']
}
def build_path(parent, start, end):
    path = []
    while end != start:
        path.append(end)
        end = parent[end]
    path.append(start)
    return path[::-1]
def bidirectional(start, goal):
    forward = deque([start])
    backward = deque([goal])
    visited_f = {start}
    visited_b = {goal}
    parent_f = {start: None}
    parent_b = {goal: None}
    meeting_node = None
    while forward and backward:
        # Forward Step
        node_f = forward.popleft()
        for neighbor in graph[node_f]:
            if neighbor not in visited_f:
                visited_f.add(neighbor)
                parent_f[neighbor] = node_f
                forward.append(neighbor)
                if neighbor in visited_b:
                    meeting_node = neighbor
                    break
        if meeting_node:
            break
        # Backward Step
        node_b = backward.popleft()
        for neighbor in graph[node_b]:
            if neighbor not in visited_b:
                visited_b.add(neighbor)
                parent_b[neighbor] = node_b
                backward.append(neighbor)
                if neighbor in visited_f:
                    meeting_node = neighbor
                    break
        if meeting_node:
            break
    if not meeting_node:
        return None
    # Build forward path
    path_f = build_path(parent_f, start, meeting_node)
    # Build backward path
    path_b = build_path(parent_b, goal, meeting_node)
    full_path = path_f + path_b[-2::-1]
    return full_path
path = bidirectional('A', 'G')
if path:
    print("Path Found:")
    print(" -> ".join(path))
else:
    print("No Path")
