<?php
require_once __DIR__ . '/../initialize.php';
header('Content-Type: application/json');

if (!isset($_SESSION['user_id'])) {
    http_response_code(401);
    echo json_encode(['success' => false, 'message' => 'User not authenticated']);
    exit();
}

try {
    // For now, return empty notifications array
    // You can enhance this later with actual notification system
    echo json_encode([
        'success' => true,
        'notifications' => []
    ]);
} catch (Exception $e) {
    error_log('Get notifications error: ' . $e->getMessage());
    echo json_encode([
        'success' => false,
        'message' => 'Failed to fetch notifications'
    ]);
}
