# learnning agent
import random

score=[]

difficulty="easy"

for round in range(1,6):
    print(f"Round {round}")
    score= random.randinit(0,100)
    print(f"Score: {score}")
    score.append(score)
    average_score=sum(score)/len(score)
    print(f"Average Score: {average_score:.2f}")
    
    if average_score>=80:
        diffculty='hard'
    elif average_score>=60:
        difficulty='medium'
    else:
        difficulty='easy'
        
    print("Game Difficulty:",difficulty)
    
    
print("Score History:",score)
final_average = sum(score) / len(score)
print("Final Average Score:", final_average)
print("Final learned Difficulty:",difficulty)
