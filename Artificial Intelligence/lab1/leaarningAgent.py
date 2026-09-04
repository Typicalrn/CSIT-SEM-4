# Learning Agent
import random

scores = []

difficulty = "easy"

for round in range(1, 6):
    print(f"\nRound {round}")

    score = random.randint(0, 100)
    print(f"Score: {score}")

    scores.append(score)

    average_score = sum(scores) / len(scores)
    print(f"Average Score: {average_score:.2f}")

    if average_score >= 80:
        difficulty = "hard"
    elif average_score >= 60:
        difficulty = "medium"
    else:
        difficulty = "easy"

    print("Game Difficulty:", difficulty)

print("\nScore History:", scores)

final_average = sum(scores) / len(scores)
print(f"Final Average Score: {final_average:.2f}")
print("Final Learned Difficulty:", difficulty)