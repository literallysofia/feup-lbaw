
 function boldUnbold (text) {
    let line = text.parentElement;
    let containsClass = line.classList.contains("unbold");
  
    if (containsClass) {
      line.classList.remove("unbold");
      line.classList.add("bold");
    } else {
      line.classList.remove("bold");
      line.classList.add("unbold");
    }
  };
    