<!DOCTYPE html>
<html>
  <head> 
    @include('admin.css')
  </head>
  <body>
    <header class="header">   
    @include('admin.header')
    </header>
    <div class="d-flex align-items-stretch">
      <!-- Sidebar Navigation-->
      @include('admin.Sidebar')
      <!-- Sidebar Navigation end-->
     
    </div>
    @include('admin.footer')
  </body>
</html>