from sqlalchemy import Column, Integer, String, DateTime, Numeric, Text, Float, Time, Boolean
from .database import Base


class Dows(Base):
    __tablename__ = "dows"
    dow = Column(String(45), primary_key=True, nullable=False)
    dow_name = Column(String(45), nullable=False)

    def __init__(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __repr__(self):
        return '<{} {!r}>'.format(type(self).__name__, self.dow)


class Goals(Base):
    __tablename__ = "goals"
    goal = Column(String(45), primary_key=True, nullable=False)
    goal_name = Column(String(45), nullable=False)

    def __init__(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __repr__(self):
        return '<{} {!r}>'.format(type(self).__name__, self.goal)


class Scheduler(Base):
    __tablename__ = "goals"
    row_id = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    teacher_id = Column(Integer, nullable=False)
    dow = Column(String(45), nullable=False)
    time = Column(Time, nullable=False)
    occupied = Column(Boolean, nullable=False)

    def __init__(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __repr__(self):
        return '<{} {!r}>'.format(type(self).__name__, self.row_id)


class TeacherGoals(Base):
    __tablename__ = "teacher_goals"
    row_id = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    teacher_id = Column(Integer, nullable=False)
    goal_id = Column(String(45), nullable=False)

    def __init__(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __repr__(self):
        return '<{} {!r}>'.format(type(self).__name__, self.row_id)


class Teachers(Base):
    __tablename__ = "teachers"
    row_id = Column(Integer, primary_key=True, autoincrement=True, nullable=False)
    id = Column(Integer, nullable=False)
    name = Column(String(100), nullable=False)
    about= Column(Text, nullable=False)
    rating= Column(Numeric(4,1), nullable=False)
    picture= Column(String(120), nullable=False)
    price= Column(Numeric(6,2), nullable=False)

    def __init__(self, **kwargs):
        for key, value in kwargs.items():
            setattr(self, key, value)

    def __repr__(self):
        return '<{} {!r}>'.format(type(self).__name__, self.row_id)