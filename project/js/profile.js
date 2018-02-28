
 function boldUnbold (text) {
    let containsClass = text.classList.contains("unbold");
  
    if (containsClass) {
      text.classList.remove("unbold");
      text.classList.add("bold");
    } else {
      text.classList.remove("bold");
      text.classList.add("unbold");
    }
  };
    