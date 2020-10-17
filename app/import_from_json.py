from app.database import db_session
from app.data import goals, dow, teachers
from app.models import Goals, Dows, TeacherGoals, Teachers, Scheduler

for key,value in goals.items():
    g = Goals(goal = key, goal_name = value)
    db_session.add(g)
db_session.commit()

for key,value in goals.items():
    g = Goals(goal = key, goal_name = value)
    db_session.add(g)
db_session.commit()
