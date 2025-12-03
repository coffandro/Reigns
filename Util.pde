boolean isHovered(PVector pos, PVector size) {
  return mouseX > pos.x - size.x/2 && mouseX < pos.x + size.x/2 &&
    mouseY > pos.y - size.x/2 && mouseY < pos.y + size.x/2;
}
