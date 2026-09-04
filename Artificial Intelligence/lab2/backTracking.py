N = 4
# Q[i] = row position of queen in column i
Q = [-1] * N
def is_safe(col):
    for j in range(col):
        # Same row
        if Q[col] == Q[j]:
            return False
        # Same diagonal
        if abs(Q[col] - Q[j]) == abs(col - j):
            return False
    return True
def solve(col):
    if col == N:
        return True
    for row in range(N):
        Q[col] = row
        if is_safe(col):
            if solve(col + 1):
                return True
    return False
if solve(0):
    print("Solution:", Q)
    for col in range(N):
        for row in range(N):
            if Q[col] == row:
                print("Q", end=" ")
            else:
                print(".", end=" ")
        print()
else:
 print("No Solution")