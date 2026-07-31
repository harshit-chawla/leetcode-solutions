SELECT score,
dense_rank() OVER (ORDER by Score DESC) as rank
from Scores;