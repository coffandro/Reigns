boolean isHovered(PVector pos, PVector size) {
  return mouseX > pos.x && mouseX < pos.x + size.x &&
    mouseY > pos.y && mouseY < pos.y + size.y;
}
