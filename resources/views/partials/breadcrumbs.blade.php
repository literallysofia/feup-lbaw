<nav class="breadcrumb container">
    <a class="breadcrumb-item" href="{{ url('/') }}">
    <i class="fas fa-home"></i> Home</a>
    @foreach($data as $name=>$route)
        @if($route == '')
            <span class="breadcrumb-item active">{{ $name }}</span>
        @else
            <a class="breadcrumb-item" href="{{ url('$route') }}">$name</a>
        @endif
    @endforeach
</nav>
