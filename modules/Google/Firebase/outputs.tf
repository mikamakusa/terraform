output "firebase_android_app" {
  value = try(
    google_firebase_android_app.this.*.id,
    google_firebase_android_app.this.*.name,
    google_firebase_android_app.this.*.app_id,
    google_firebase_android_app.this.*.api_key_id,
    google_firebase_android_app.this.*.deletion_policy,
  )
}

output "firebase_apple_app" {
  value = try(
    google_firebase_apple_app.this.*.id,
    google_firebase_apple_app.this.*.name,
    google_firebase_apple_app.this.*.app_id,
    google_firebase_apple_app.this.*.api_key_id,
    google_firebase_apple_app.this.*.deletion_policy
  )
}

output "firebase_web_app" {
  value = try(
    google_firebase_web_app.this.*.id,
    google_firebase_web_app.this.*.name,
    google_firebase_web_app.this.*.app_id,
    google_firebase_web_app.this.*.api_key_id,
    google_firebase_web_app.this.*.deletion_policy
  )
}