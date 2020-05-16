# frozen_string_literal: true

class JsonToHtml
  attr_accessor :config

  def initialize(config)
    @config = config.map(&method(:el)).join("\n")
  end

  def el(obj)
<<-HTML
<div class="task #{obj[:done] ? done : ''}">
  #{obj.keys.map { |tag| "<#{tag}>#{obj[tag]}</#{tag}>" }.join("\n")}
</div>
HTML
  end

  def html
<<-HTML
<html lang="en">
  #{html_head}
  #{html_body(@config)}
</html>
HTML
end

  def html_body(contents)
<<-HTML
<body>
  <div onclick="previous()" class="nav-arrow"><span class="arrow">⤴</span></div>
  <div class="content">
    #{contents}
    <div class="all-done">DONE!</div>
  </div>
  <div onclick="next()" class="nav-arrow"><span class="arrow">⤵</span></div>

  <script>
    function previous() {
      tasks = [...document.querySelectorAll(".task")].reverse()
      for (t of tasks) {
        if (t.className.includes("done")) {
          t.className = "task"
          return
        }
      }

    }

    function next() {
      tasks = [...document.querySelectorAll(".task")]
      for (t of tasks) {
        if (t.className.includes("done")) continue;

        t.className += " done"
        return
      }
    }
  </script>
</body>
HTML
end

  def html_head
<<-HTML
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/kognise/water.css@latest/dist/dark.min.css">
  <link rel="stylesheet" href="style.css">
  <style>
  body {
    margin: 0;
    padding-top: 10px;
  }

  .content {
    /* background-image: linear-gradient(slategray, white); */
    background-image: url("https://picsum.photos/seed/picsum/200?random=1");
    background-repeat: no-repeat;
    background-size: cover;
    padding: 5px;
    border: thin dotted white;
    height: 70vh;
    width: 70vw;
    overflow: hidden;
  }

  h2 {
    color: black;
  }

  .task {
    padding-top: 50px;
    color: black;
    height: 100%;
    width: 100%;
    text-align: center;
    height: 70vh;
    margin-bottom: 30vh;
  }

  .task.done {
    display: none
  }

  .nav-arrow {
    border-radius: 3px;
    margin: 5px;
    text-align: center;
    opacity: 0.6;
    background-color: lightgreen;
    width: 50%;
    min-height: 5vh;
    font-size: 2rem;
    cursor: pointer;
    color: white;
    float: right;
  }

  .nav-arrow:hover {
    transition: 0.2s;
    opacity: 1;
  }

  .all-done {
    min-height: 70vh;
    min-width: 70vh;
    border: thick black;
    color: black;
    font-size: 4rem;
  }
  </style>
  <title>Do it to it</title>
</head>
HTML
  end
end
