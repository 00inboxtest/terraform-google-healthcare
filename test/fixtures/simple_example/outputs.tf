/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

output "dataset_name" {
  description = "The name of the dataset."
  value       = random_pet.main.id
}

output "project" {
  description = "The ID of the project in which resources are provisioned."
  value       = var.project
}

output "group_email" {
  description = "Email for group that received roles (ex. group@example.com)"
  value       = var.group_email
}

output "sa_email" {
  description = "Email for Service Account that received roles (Ex. default-sa@example-project-id.iam.gserviceaccount.com)"
  value       = var.sa_email
}

output "user_email" {
  description = "Email for user that received roles (Ex. user@example.com)"
  value       = var.user_email
}

output "pubsub_topic" {
  description = "Pubsub Topic name"
  value       = var.pubsub_topic
}
