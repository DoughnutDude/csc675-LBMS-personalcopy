# In this file, students must implement database modeling techniques for all their entities.
import database as db


class Library:

  def __init__(self, lib_id):
    self.id = lib_id
    self.loadData(self)

  def loadData(self):
    db.load(type(self).__name__, self.id)
