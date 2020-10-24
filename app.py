import uuid
import random

from flask import Flask, render_template, request

from models import Goals, Dows, Teachers, ViewSchedulerDows, ViewTeacherGoals
from database import db_session, call_stored_procedure

app = Flask(__name__)


@app.route("/")
def main():
    gl = Goals.query.all()
    db = Teachers.query.all()
    list_id = []
    for i in db:
        list_id.append(i)
    random.shuffle(list_id)
    return render_template("index.html", gl=gl, db=db, teacher_list=list_id[0:6])


@app.route("/goals/<goal>")
def goals(goal):
    db_goal = Teachers.query.order_by(Teachers.rating.desc()).all()
    goal = Goals.query.filter(Goals.goal == goal).first()
    return render_template("goal.html", db=db_goal, goal=goal)


@app.route("/profiles/<pid>")
def profiles(pid):
    db = Teachers.query.filter(Teachers.id == pid).first()
    gl = ViewTeacherGoals.query.filter(ViewTeacherGoals.teacher_id == db.row_id).all()
    scheduler_dows = ViewSchedulerDows.query.filter(ViewSchedulerDows.teacher_id == db.row_id).all()
    return render_template("profile.html", db_teacher=db, gl=gl, scheduler_dows=scheduler_dows)


@app.route("/request")
def req():
    gl = Goals.query.all()
    return render_template("request.html", gl=gl)


@app.route("/request_done", methods=["POST"])
def request_done():
    rd_new = {}
    for i in request.form.keys():
        rd_new[i] = request.form.get(i)
    param_list = [str(uuid.uuid4()),
                  request.form.get("goal"),
                  request.form.get("time"),
                  request.form.get("customer_name"),
                  request.form.get("customer_phone")]

    call_stored_procedure(proc_name="sp_add_teacher_request", param_list=param_list)
    gl = Goals.query.filter(Goals.goal == request.form.get("goal")).first()
    return render_template("request_done.html", customer=rd_new, gl=gl)


@app.route("/booking/<pid>/<day>/<time>")
def booking(pid, day, time):
    param_list = [pid, day, time + ":00:00", "@p_row_id"]
    scheduler_id = call_stored_procedure(proc_name="sp_get_scheduler_id", param_list=param_list)

    db = Teachers.query.filter(Teachers.id == pid).first()
    dow = Dows.query.filter(Dows.dow == day).first()
    return render_template("booking.html",
                           db_teacher=db,
                           day=dow.dow_name,
                           time=time,
                           dow=day,
                           scheduler_id=scheduler_id[0])


@app.route("/booking_done", methods=["POST"])
def booking_done():
    rd = {}
    for i in request.form.keys():
        rd[i] = request.form.get(i)

    param_list = [str(uuid.uuid4()), request.form.get("schedulerId"),
                  request.form.get("clientName"), request.form.get("clientPhone")]
    call_stored_procedure(proc_name="sp_add_booking_request", param_list=param_list)
    db = Teachers.query.filter(Teachers.row_id == request.form.get("clientTeacher")).first()
    dow = Dows.query.filter(Dows.dow == request.form.get("clientWeekday")).first()
    return render_template("booking_done.html",
                           request_data=rd,
                           db_teacher=db,
                           day=dow)


@app.teardown_appcontext
def shutdown_session(exception=None):
    db_session.remove()


if __name__ == '__main__':
    app.run()
