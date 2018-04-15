<!DOCTYPE html>
<html lang="{{ app()->getLocale() }}">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- CSRF Token -->
    <meta name="csrf-token" content="{{ csrf_token() }}">

    <title>{{ config('app.name', 'Laravel') }}</title>

    <!-- Styles -->
    <!--<link href="{{ asset('css/milligram.min.css') }}" rel="stylesheet">-->
    <link href="{{ asset('css/app.css') }}" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
        crossorigin="anonymous">
    <link href="https://use.fontawesome.com/releases/v5.0.6/css/all.css" rel="stylesheet">
    <script defer src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
        crossorigin="anonymous"></script>
    <script defer src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
        crossorigin="anonymous"></script>
    <script defer src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
        crossorigin="anonymous"></script>
    <script type="text/javascript">
        // Fix for Firefox autofocus CSS bug
        // See: http://stackoverflow.com/questions/18943276/html-5-autofocus-messes-up-css-loading/18945951#18945951
    </script>
    <script type="text/javascript" src={{ asset('js/app.js') }} defer>
</script>
  </head>
  <body>
    <header>
        <nav class="navbar navbar-expand-md fixed-top navbar-light">
            <div class="container">
                <!-- HAMBURGER -->
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target=".navbar-collapse" aria-expanded="false"
                    aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>

                <!-- LOGO -->
                <a class="navbar-brand mr-auto" href="{{ url('/homepage') }}">Sweven</a>

                <ul class="navbar-nav d-flex flex-row align-items-center">
                    <!-- DROPDOWN -->
                    <li class="nav-item dropdown d-none d-md-block">
                        <a class="nav-link dropdown-toggle" href="#" role="button" id="dropdownMenuLink" data-toggle="dropdown" aria-haspopup="true"
                            aria-expanded="false">
                            Products
                        </a>

                        <div class="dropdown-menu" aria-labelledby="dropdownMenuLink">
                            <div class="triangle"></div>
                            <h6 class="dropdown-header">Shop By Category</h6>
                            <div class="dropdown-divider"></div>
                            <a class="dropdown-item" href="products.html">Smartphones</a>
                            <a class="dropdown-item" href="products.html">Tablets</a>
                            <a class="dropdown-item" href="products.html">Computers</a>
                            <a class="dropdown-item" href="products.html">Monitors</a>
                            <a class="dropdown-item" href="products.html">Acessories</a>

                        </div>
                    </li>
                    <!-- SEARCH -->
                    <li>
                        <form class="form-inline search-container d-none d-md-flex">
                            <i class="fas fa-search search-icon"></i>
                            <input class="form-control mr-sm-2" type="text" placeholder="Search">
                        </form>
                    </li>
                    <!-- ICONS -->
                    <li class="nav-item">
                        <a class="nav-link" href="{{url('/wishlist')}}">
                            <i class="fas fa-heart"></i>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="{{url('/cart')}}">
                            <i class="fas fa-shopping-bag"></i>
                        </a>
                    </li>
                    @if (Auth::check())
                        @if (Route::currentRouteName() == 'profile')
                        <li class="nav-item">
                            <a class="nav-link" href="{{ route('logout') }}">
                                <i class="fas fa-power-off"></i>
                            </a>
                        </li>
                        @else
                        <li class="nav-item">
                            <a class="nav-link" href="{{ route('profile', [Auth::id()]) }}">
                                <i class="fas fa-user"></i>
                            </a>
                        </li>
                        @endif
                    @else
                    <li class="nav-item">
                        <a class="nav-link" href="{{url('/signin')}}">Sign In</a>
                    </li>
                    @endif
                </ul>

                <!-- MOBILE MENU -->
                <div class="d-block d-md-none w-100">
                    <div class="collapse navbar-collapse">
                        <ul class="navbar-nav mr-auto">
                            <li class="nav-item">
                                <h6>Shop By Category</h6>
                                <hr>
                            </li>

                            <li class="nav-item">
                                <a class="nav-link" href="products.html">Smartphones</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="products.html">Tablets</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="products.html">Computers</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="products.html">Monitors</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="products.html">Acessories</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <form class="search-container-mobile d-flex flex-row flex-nowrap d-md-none form-inline my-2 my-lg-0">
                    <input class="form-control mr-2 w-100" type="text" placeholder="Search">
                    <button class="btn my-2 my-sm-0" type="submit">
                        <i class="fas fa-search search-icon"></i>
                    </button>
                </form>
            </div>
        </nav>
    </header>
        @yield('content')
    <footer class="page-footer">
      <div class="container">
          <div class="row">
              <div class="col-md-6">
                  <h5 class="title">Help</h5>
                  <ul class="list-unstyled">
                      <li>
                          <a href="{{ url('/contact') }}">Contact</a>
                      </li>
                      <li>
                          <a href="{{ url('/faq') }}">FAQs</a>
                      </li>
                      <li>
                          <a href="{{ url('/about') }}">About</a>
                      </li>
                  </ul>
              </div>

              <div class="col-md-6 d-flex justify-content-end align-items-end">
                  <p>© Copyright 2018 Sweven. All rights reserved.</p>
              </div>
          </div>
      </div>
    </footer>
  </body>
</html>
