@extends('layouts.client')

@section('title', 'Initialize')

@section('content')
<h1>Welcome, {{ $user->name }}</h1>
<p>Email: {{ $user->email }}</p>
<!-- Add more user info or page content as needed -->
@endsection