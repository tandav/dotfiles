class State:
    CREATED = ' '
    RUNNING = 'r'
    FAILED  = 'f'
    DONE    = 'd'

class Graph:

    blueprint = '''
    ┌─────┐                              ┌─────┐
    │     a──────────────────────────────b     │
    │  Al │     ┌─────┐                  │     │
    │     c─────d     │                  │     │
    └─────┘     │     │                  │     │
    ┌─────┐     │  Dm │     ┌─────┐      │  Fp │
    │     │     │     f─────g     │      │     │
    │  Bq e─────r     │     │     │      │     │
    │     │     └─────┘     │     │      │     │
    └─────┘                 │  En h──────i     │
    ┌─────┐                 │     │      │     │
    │     │                 │     │      └─────┘
    │  Co j─────────────────k     │             
    │     │                 └─────┘             
    └─────┘                                     
    '''
    state_places = dict(A='l', B='q', C='o', D='m', E='n', F='p')
    def __init__(self):
        self.A = State.CREATED
        self.B = State.CREATED
        self.C = State.CREATED
        self.D = State.CREATED
        self.E = State.CREATED
        self.F = State.CREATED

        self.nodes = [getattr(self, n) for n in 'ABCDEF']
        self.arrow = None
    def __repr__(self):
        result = self.blueprint
        placeholders = dict(AF='b▶', FA='a◀', AD='d▶', DA='c◀', DE='g▶', ED='f◀', EF='i▶', FE='h◀', BD='r▶', DB='e◀', CE='k▶', EC='j◀')
        for place, default in zip('abcdefghijkr', '├┤├┤├├┤├┤├┤┤'):
            if self.arrow and placeholders[self.arrow][0] == place:
                value = placeholders[self.arrow][1]
            else:
                value = default
            result = result.replace(place, value)
        for node in 'ABCDEF':
            result = result.replace(self.state_places[node], getattr(self, node))
        return result

g = Graph()
