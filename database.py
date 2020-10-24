from sqlalchemy import create_engine, text
from sqlalchemy.orm import scoped_session, sessionmaker
from sqlalchemy.ext.declarative import declarative_base

engine = create_engine('mysql+pymysql://stepik4:stepik4@localhost/stepik4', convert_unicode=True)
db_session = scoped_session(sessionmaker(autocommit=False,
                                         autoflush=False,
                                         bind=engine))
Base = declarative_base()
Base.query = db_session.query_property()


def call_stored_procedure(proc_name=None, param_list=None, fetchtype="fetchone"):
    """
    :param proc_name: - имя вызываемой хранимой процедуры, "my_procedure"
    :param param_list: - список параметорв хранимой процедуры, ['x', 'y', 'z']
    :param fetchtype: - тип ожидаемого ответа
    :return: список
    """

    connection = engine.raw_connection()
    try:
        cursor = connection.cursor()
        if param_list is None:
            cursor.callproc(proc_name)
        else:
            cursor.callproc(proc_name, param_list)

        if fetchtype == "fetchall":
            results = cursor.fetchall()
        elif fetchtype == "fetchmany":
            results = cursor.fetchmany()
        else:
            results = cursor.fetchone()
        cursor.close()
        connection.commit()
    finally:
        connection.close()

    return results
