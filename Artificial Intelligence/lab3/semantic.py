import networkx as nx
import matplotlib.pyplot as plt

graph = {
"Animal": [],
"Bird": ["Animal"],
"Parrot": ["Bird"],
"CanFly": ["Parrot"],
"Green": ["Parrot"]
}
print("Semantic Network")
for node in graph:
    print(node, "->", graph[node])


G = nx.DiGraph()
G.add_edge("Bird", "Animal", relation="is-a")
G.add_edge("Parrot", "Bird", relation="is-a")
G.add_edge("Parrot", "CanFly", relation="can")
G.add_edge("Parrot", "Green", relation="color")
pos = nx.spring_layout(G)
nx.draw(G, pos, with_labels=True, node_size=2000)
edge_labels = nx.get_edge_attributes(G, "relation")
nx.draw_networkx_edge_labels(
G,
pos,
edge_labels=edge_labels
)
plt.show()