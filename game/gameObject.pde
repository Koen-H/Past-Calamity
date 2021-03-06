class GameObject {
  protected int x;
  protected int y;
  protected int owidth;
  protected int oheight;
  protected String identifier;
  private boolean hasImage;
  private boolean hasHoverImage;
  private PImage gameObjectImage;
  private PImage gameObjectImageHover;
  protected boolean mouseIsHovering;
  protected AudioPlayer soundEffect;

  protected String method = null;    //what does this do?

  public GameObject(String identifier, int x, int y, int owidth, int oheight) {
    this(identifier, x, y, owidth, oheight, "", null);
  }

  public GameObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile) {
    this.identifier = identifier;
    this.x = x;
    this.y = y;
    this.owidth = owidth;
    this.oheight = oheight;
    this.hasImage = !gameObjectImageFile.equals(""); 
    if (this.hasImage) {
      this.gameObjectImage = loadImage(gameObjectImageFile);
    }
    hasHoverImage = false;
    mouseIsHovering = false;
  }
  public GameObject(String identifier, int x, int y, int owidth, int oheight, String gameObjectImageFile, AudioPlayer soundEffect) {
    this.identifier = identifier;
    this.x = x;
    this.y = y;
    this.owidth = owidth;
    this.oheight = oheight;
    this.hasImage = !gameObjectImageFile.equals(""); 
    if (this.hasImage) {
      this.gameObjectImage = loadImage(gameObjectImageFile);
    }
    hasHoverImage = false;
    mouseIsHovering = false;
    this.soundEffect = soundEffect;
  }

  public void setHoverImage(String gameObjectImageHoverFile) {
    this.gameObjectImageHover = loadImage(gameObjectImageHoverFile);
    hasHoverImage = true;
  }

  public void setMethod(String method) {
    this.method = method;
  }

  public void draw() {
    if (hasImage) {
      if (mouseIsHovering && hasHoverImage && !isDialogueActive) {
        // println("isHovering");
        image(gameObjectImageHover, x, y, owidth, oheight);
      } else {
        image(gameObjectImage, x, y, owidth, oheight);
      }
    }
  }

  public void mouseMoved() {
    mouseIsHovering = false;
    if (mouseX >= x && mouseX <= x + owidth &&
      mouseY >= y && mouseY <= y + oheight) {
      mouseIsHovering = true;
      //fill(1,1,1,0);
      //rect(x, y, owidth, oheight);
    }
  }

  public void mouseClicked() { 
    if (mouseIsHovering) {
      if (method != null) {
        method(method);
      }
    }
  }

  public String getIdentifier() {
    return this.identifier;
  }

  @Override 
    public boolean equals(Object obj) { 
    if (obj == this) { 
      return true;
    } 
    if (obj == null || obj.getClass() != this.getClass()) { 
      return false;
    } 
    GameObject otherGameObject = (GameObject) obj; 
    return otherGameObject.getIdentifier().equals(this.identifier);
  } 

  @Override 
    public int hashCode() { 
    final int prime = 11;
    return prime * this.identifier.hashCode();
  }
}
