class Player(object):

    
    CHARACTERS = ['mafia', 'civil']

    def __init__(self, name, is_host = False):
        self.name = name
        self.is_host = is_host
        self.is_alive = True
        self.character = 'civil'
        
    def to_dict(self):
        return self.__dict__

    def kill(self):
        self.is_alive = False

    def set_character(self, character):
        if character in self.CHARACTERS:
            self.character = character
        else:
            raise CharacterNotSupportedException

class CharacterNotSupportedException(Exception):
    pass
