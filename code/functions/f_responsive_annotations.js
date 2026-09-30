f_responsive_annotations <- function(plot) {
  htmlwidgets::onRender(
    plot,
    "
    function(el, x) {
      function resizeAnnotations() {
        var width = el.offsetWidth;

        var size;
        var axisSize;

        /* Update annotation size based on chart width */
        if (width < 400) {
          axisSize = 7;
          size = 7;
        } else if (width < 700) {
          axisSize = 10;
          size = 10;
        } else {
          axisSize = 14;
          size = 14;
        }

        if (!el.layout.annotations) {
          return;
        }

        var anns = el.layout.annotations.map(
          function(a) {
            if (!a.font) {
              a.font = {};
            }

            a.font.size = size;

            return a;
          }
        );

        Plotly.relayout(
          el,
          {
            annotations: anns,
            'xaxis.tickfont.size': axisSize,
            'yaxis.tickfont.size': axisSize
          }
        );
      }

      resizeAnnotations();

      /* Call resize code on resize event */
      window.addEventListener(
        'resize',
        resizeAnnotations
      );
    }
    "
  )
}
