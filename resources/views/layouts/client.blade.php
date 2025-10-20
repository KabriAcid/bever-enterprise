<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Frozen Foods')</title>
    <link rel="shortcut icon" href="{{ asset('img/favicon.png') }}" type="image/x-icon">
    <link rel="stylesheet" href="{{ asset('css/tailwind.css') }}">
    <link rel="stylesheet" href="{{ asset('css/style.css') }}">
    @stack('head')
</head>

<body>
    @include('client.partials.top-nav')
    <main class="min-h-screen">
        @yield('content')
    </main>
    @include('client.partials.bottom-nav')
    @stack('scripts')
</body>

</html>