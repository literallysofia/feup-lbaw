function boldUnboldLine(line) {

  let containsClass = line.classList.contains("unbold");

  if (containsClass) {
    line.classList.remove("unbold");
    line.classList.add("bold");
  } else {
    line.classList.remove("bold");
    line.classList.add("unbold");
  }
}

function boldUnboldText(text) {

  line = text.parentElement;

  let containsClass = line.classList.contains("unbold");

  if (containsClass) {
    line.classList.remove("unbold");
    line.classList.add("bold");
  } else {
    line.classList.remove("bold");
    line.classList.add("unbold");
  }
}

