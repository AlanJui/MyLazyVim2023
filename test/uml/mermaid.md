<!-- markdownlint-disable MD013 MD024 MD033 MD040 MD043 -->

# 為漢字標註讀音

[![Diagram Image Link](https://tinyurl.com/2bkmhu6x)](https://tinyurl.com/2bkmhu6x)<!--![Diagram Image Link](d100_fn001.puml)-->

## 使用者需求

使用者可輸入一段「漢字」，或一篇文章。系統將為每個漢字標註「
福建話音標」。

### 作業程序

1. 使用者在瀏覽器輸入網址（URI: /article_pronunciation/）。

   【URI 網址】 /article_pronunciation/pronunciation/

2. 系統顯示「輸入文章」表單。

3. 使用者先在表單中輸入文章，然後按《提交》按鈕。

4. 系統處理輸入之文章，為每個漢字標註「福建話音標」。最後，
   向使用者顯示已標註福建話音標之文章。

   【URI 網址】 /article_pronunciation/pronunciation/

## 系統需求規格

```mermaid
sequenceDiagram
    participant User
    participant Browser
    participant System

    User->>Browser: 輸入URI 網址：<br>/article_pronunciation/input/
    Browser->>System: 發送系統功能指令 (HTTP GET Request)
    System->>Browser: 回傳表單網頁 (HTTP Response)
    Browser->>User: 依據 HTTP Response 顯示網頁
    User->>Browser: 在網頁中的表單輸入漢字並按提交鈕
    Browser->>System: 發送 HTTP POST Request（表單中輸入的漢字）
    System->>System: 處理輸入的漢字，將之標註讀音
    Note over System: 為文章中的每個漢字標註福建話音標。
    System->>Browser: 重導 URI 網址：<br>/article_pronunciation/pronunciation/
    Browser->>User: 顯示標註讀音的漢字
    Note over User,Browser: 文章中的每個漢字都標註有它的讀音。
```

## 系統設計規格

<!-- ![Entity-Control-Boundary Sequence Diagram](/d100_URS/imgs/d100_fn001.png) -->

<!-- <center> -->
<!--   <img src="/d100_URS/imgs/d100_fn001.png" alt="Hero image" width="600" height="400"> -->
<!-- </center> -->

### PlantUML 語法

```plantuml
actor    User
control  Django.Router  as Router
control  Django.Template as Template
boundary post_detail      as View
boundary CommentForm      as Form
entity   Post    as Model
entity   Comment   as Comment
database database   as DB

User -> Router : url: /blog/  (post_detail)
Router -> View : post_detail(request, year, month, day, post)
View -> Model : get_object_or_404(Post, slug=post, \n status='published', publish__year=year, \n publish__month=month, publish__day=day)
Model -> DB : sql_query()
DB --> Model : post
Model --> View : post
View -> Comment: post.comments.filter(active=True)
Comment --> View: comments
View -> Form: CommentForm()
Form --> View: form
View --> Template: render(request, \n uri_of_template, \n {post, comments, form})
Template --> User: /blog/post/list.html
```

### Mermaid 語法

<mermaid />

```mermaid
sequenceDiagram
  participant User
  participant Router as Django.Router
  participant View as post_detail
  participant Model as Post
  participant Comment
  participant Form as CommentForm
  participant Template as Django.Template
  participant DB as database

  User->>Router: url: /blog/ (post_detail)
  Router->>View: post_detail(request, year, month, day, post)
  View->>Model: get_object_or_404(Post, slug=post, status='published', publish__year=year, publish__month=month, publish__day=day)
  Model->>DB: sql_query()
  DB-->>Model: post
  Model-->>View: post
  View->>Comment: post.comments.filter(active=True)
  Comment-->>View: comments
  View->>Form: CommentForm()
  Form-->>View: form
  View-->>Template: render(request, uri_of_template, {post, comments, form})
  Template-->>User: /blog/post/list.html
```

### 網頁架構

<mermaid />

```mermaid
graph TD

    A(首頁)
    B(漢字字典)
    C(加註讀音)
    D(後台管理)

    A --> B
    A --> C
    A --> D
```

::: tip A to C: 漢字讀音，取自漢字字典 :::

<mermaid />

```mermaid
stateDiagram-v2

    [*] --> Still
    Still --> [*]
    Still --> Moving
    Moving --> Still
    Moving --> Crash
    Crash --> [*]
```
