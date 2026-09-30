if (!document.getElementById("add-annotation-button")) {
  var button = document.createElement("button");

  button.id = "add-annotation-button";
  button.innerHTML = "Add Annotation";

  button.addEventListener("click", function() {
    var annotationDiv = document.createElement("div");
    var annotationId =
      "annotation-" +
      Math.random()
        .toString(36)
        .substr(2, 9);

    annotationDiv.className = "ybaannotation";

    annotationDiv.setAttribute(
      "data-annotation-id",
      annotationId
    );

    annotationDiv.style.left = "50%";

    annotationDiv.style.top =
      window.innerHeight / 2 -
      annotationDiv.offsetHeight / 2 +
      window.pageYOffset +
      "px";

    annotationDiv.style.width = "240px";

    var p = document.createElement("p"); // create a new p element

    p.innerHTML = "Click to edit annotation";
    // set the initial text of the p element

    annotationDiv.appendChild(p);

    var textarea = document.createElement("textarea");

    textarea.style.display = "none"; // hide the textarea initially
    textarea.style.width = "100%"; // set the width to 100%
    textarea.style.boxSizing = "border-box";
    // set the box-sizing property to border-box

    textarea.addEventListener("input", function() {
      this.style.height = "auto";
      this.style.height = this.scrollHeight + "px";
    });

    annotationDiv.appendChild(textarea);
    document.body.appendChild(annotationDiv);

    // Add blur event listener to the textarea to replace it with the p element
    textarea.addEventListener("blur", function() {
      p.innerHTML =
        this.value ||
        "Click to add annotation";

      // set the text of the p element to the textarea value,
      // or the default text if it's empty
      textarea.style.display = "none";
      p.style.display = "block";
    });

    // Add click event listener to the p element to replace it with the textarea
    p.addEventListener("click", function() {
      p.style.display = "none";
      textarea.style.display = "block";
      textarea.focus();
    });

    var isDragging = false;
    var startX;
    var startY;
    var startLeft;
    var startTop;

    annotationDiv.addEventListener("mousedown", function(e) {
      isDragging = true;
      startX = e.clientX;
      startY = e.clientY;

      startLeft = parseInt(
        window
          .getComputedStyle(this)
          .getPropertyValue("left"),
        10
      );

      startTop = parseInt(
        window
          .getComputedStyle(this)
          .getPropertyValue("top"),
        10
      );
    });

    document.addEventListener("mousemove", function(e) {
      if (isDragging) {
        var dx = e.clientX - startX;
        var dy = e.clientY - startY;

        annotationDiv.style.left =
          startLeft + dx + "px";

        annotationDiv.style.top =
          startTop + dy + "px";
      }
    });

    document.addEventListener("mouseup", function() {
      isDragging = false;
    });
  });

  document.body.appendChild(button);
}

if (!document.getElementById("save-annotations-button")) {
  var saveButton = document.createElement("button");

  saveButton.id = "save-annotations-button";
  saveButton.innerHTML = "Save annotated file";
  saveButton.style.color = "white";

  saveButton.addEventListener("click", function() {
    saveAnnotations();
  });

  document.body.appendChild(saveButton);
}

function saveAnnotations() {
  // Temporarily remove buttons from the DOM
  var addButton = document.getElementById(
    "add-annotation-button"
  );

  var saveButton = document.getElementById(
    "save-annotations-button"
  );

  if (addButton) {
    addButton.remove();
  }

  if (saveButton) {
    saveButton.remove();
  }

  var annotations = [];

  var annotationDivs =
    document.getElementsByClassName(
      "ybaannotation"
    );

  for (var i = 0; i < annotationDivs.length; i++) {
    var annotationId =
      annotationDivs[i].getAttribute(
        "data-annotation-id"
      );

    var annotationHtml =
      annotationDivs[i].outerHTML;

    annotations.push({
      id: annotationId,
      html: annotationHtml
    });
  }

  var pageHtml = document.documentElement.outerHTML;
  var annotationCss = "";

  for (var j = 0; j < annotations.length; j++) {
    annotationCss +=
      '.ybaannotation[data-annotation-id="' +
      annotations[j].id +
      '"] {' +
      annotationDivs[j].style.cssText +
      "}\n";
  }

  var style = document.createElement("style");

  style.type = "text/css";

  style.appendChild(
    document.createTextNode(annotationCss)
  );

  pageHtml = pageHtml.replace(
    "</head>",
    style.outerHTML + "</head>"
  );

  var blob = new Blob(
    [pageHtml],
    {
      type: "text/html;charset=utf-16"
    }
  );

  var link = document.createElement("a");
  var path = window.location.pathname;

  var page = path
    .split("/")
    .pop();

  // e.g. "report.html" or "annotated-save-2-report.html"
  let baseName = page;
  let saveCount = 1;

  // Check if filename starts with "annotated-save-"
  if (page.startsWith("annotated-save-")) {
    // Extract current save number using RegExp
    const match = page.match(
      /^annotated-save-(\d+)-(.*)$/
    );

    if (match) {
      saveCount =
        parseInt(
          match[1],
          10
        ) + 1;

      // increment the save number
      baseName = match[2];
      // rest of the filename (e.g. "report.html")
    }
  } else if (page.startsWith("annotated-")) {
    // Handle legacy: "annotated-report.html" →
    // turn into "annotated-save-1-report.html"
    baseName = page.replace(
      /^annotated-/,
      ""
    );
  }

  const newFilename =
    `annotated-save-${saveCount}-${baseName}`;

  link.download = newFilename;
  link.href = URL.createObjectURL(blob);

  link.click();

  // Restore buttons back to the DOM if needed
  if (addButton) {
    document.body.appendChild(addButton);
  }

  if (saveButton) {
    document.body.appendChild(saveButton);
  }
}

document.addEventListener(
  "DOMContentLoaded",
  function() {
    var toc = document.getElementById("TOC");

    if (!toc) {
      return;
    }

    setTimeout(function() {
      const allTocLists = toc.querySelectorAll(
        'ul[id^="tocify-header"]'
      );

      let firstSeen = false;

      for (let i = 0; i < allTocLists.length; i++) {
        const ul = allTocLists[i];

        if (ul.id === "tocify-header0") {
          if (!firstSeen) {
            firstSeen = true; // keep the first one
          } else {
            // This is the second or later occurrence of the ToC,
            // remove from here onward
            for (
              let j = i;
              j < allTocLists.length;
              j++
            ) {
              allTocLists[j].remove();
            }

            break;
          }
        }
      }

      const navPills =
        document.getElementsByClassName(
          "nav-pills"
        );

      for (
        let i = navPills.length - 1;
        i >= 0;
        i--
      ) {
        const pill = navPills[i];
        const firstChild =
          pill.firstElementChild;

        if (
          firstChild &&
          firstChild.textContent === "undefined"
        ) {
          pill.parentNode.removeChild(pill);
        }
      }
    }, 200); // slight delay to let tocify populate the DOM
  }
);