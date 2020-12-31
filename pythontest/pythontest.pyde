
def setup():
    size(480, 120)
    nparray = np.Array([1,4,5])
    
def draw():
    if  mousePressed:
        fill(0)
    else:
        fill(255)
    ellipse(mouseX, mouseY, 80, 80)
