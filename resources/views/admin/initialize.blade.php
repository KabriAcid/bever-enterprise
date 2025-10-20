@extends('layouts.admin')

@section('title', 'Admin Initialize')

@section('content')
<h1>Welcome, {{ $admin->name ?? 'Admin' }}</h1>
<p>Email: {{ $admin->email ?? 'N/A' }}</p>
<!-- Add more admin info or page content as needed -->
@endsection