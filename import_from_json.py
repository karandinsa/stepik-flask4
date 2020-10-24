from database import db_session
from data import goals, dow, teachers
from models import Goals, Dows, TeacherGoals, Teachers, Scheduler


for key,value in goals.items():
    g = Goals(goal = key, goal_name = value)
    db_session.add(g)


for key,value in dow.items():
    days_order = {"mon":1,"tue":2,"wed":3,"thu":4,"fri":5,"sat":6,"sun":7}
    d = Dows(dow = key, dow_name = value, dow_order=days_order[key])
    db_session.add(d)
db_session.commit()

for teacher in teachers:
    t = Teachers(id = teacher["id"],
                 name = teacher["name"],
                 about= teacher["about"],
                 rating= teacher["rating"],
                 picture= teacher["picture"],
                 price= teacher["price"])
    db_session.add(t)
    db_session.flush()
    db_session.refresh(t)
    for goal in teacher["goals"]:
        g = TeacherGoals(teacher_id = t.row_id,goal_id=goal)
        db_session.add(g)

    for key,value in teacher["free"].items():
        for key1, value1 in value.items():
            s = Scheduler(teacher_id = t.row_id, dow_id = key, time = key1, occupied = value1)
            db_session.add(s)

db_session.commit()


