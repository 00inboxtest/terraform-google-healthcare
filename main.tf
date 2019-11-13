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

resource "google_healthcare_dataset" "dataset" {
    provider = google-beta
    name = var.name
    project = var.project
    location = var.location
    time_zone = var.time_zone
}

resource "google_healthcare_dataset_iam_member" "dataset_iam_members" {
    provider = google-beta
    for_each = {
        for m in var.iam_members:
            "${m.role} ${m.member}" => m
    }
    dataset_id = google_healthcare_dataset.dataset.id
    role = each.value.role
    member = each.value.member
}

resource "google_healthcare_dicom_store" "dicom_stores" {
    provider = google-beta
    for_each = {
        for s in var.dicom_stores:
            s.name => s
    }
    name = each.value.name
    dataset = google_healthcare_dataset.dataset.id
}

resource "google_healthcare_fhir_store" "fhir_stores" {
    provider = google-beta
    for_each = {
        for s in var.fhir_stores:
            s.name => s
    }
    name = each.value.name
    dataset = google_healthcare_dataset.dataset.id
}

resource "google_healthcare_hl7_v2_store" "hl7_v2_stores" {
    provider = google-beta
    for_each = {
        for s in var.hl7_v2_stores:
            s.name => s
    }
    name = each.value.name
    dataset = google_healthcare_dataset.dataset.id
}

locals {
    all_dicom_iam_members = flatten([
        for s in var.dicom_stores: [
            for m in s.iam_members: {
                store_id = google_healthcare_dicom_store.dicom_stores[s.name].id
                role = m.role
                member = m.member
            }
        ]
    ])
    all_fhir_iam_members = flatten([
        for s in var.fhir_stores: [
            for m in s.iam_members: {
                store_id = google_healthcare_fhir_store.fhir_stores[s.name].id
                role = m.role
                member = m.member
            }
        ]
    ])
    all_hl7_v2_iam_members = flatten([
        for s in var.hl7_v2_stores: [
            for m in s.iam_members: {
                store_id = google_healthcare_hl7_v2_store.hl7_v2_stores[s.name].id
                role = m.role
                member = m.member
            }
        ]
    ])
}

resource "google_healthcare_dicom_store_iam_member" "dicom_store_iam_members" {
    provider = google-beta
    for_each = {
        for m in local.all_dicom_iam_members:
            "${m.store_id} ${m.role} ${m.member}" => m
    }
    dicom_store_id = each.value.store_id
    role = each.value.role
    member = each.value.member
}

resource "google_healthcare_fhir_store_iam_member" "fhir_store_iam_members" {
    provider = google-beta
    for_each = {
        for m in local.all_fhir_iam_members:
            "${m.store_id} ${m.role} ${m.member}" => m
    }
    fhir_store_id = each.value.store_id
    role = each.value.role
    member = each.value.member
}

resource "google_healthcare_hl7_v2_store_iam_member" "hl7_v2_store_iam_members" {
    provider = google-beta
    for_each = {
        for m in local.all_hl7_v2_iam_members:
            "${m.store_id} ${m.role} ${m.member}" => m
    }
    hl7_v2_store_id = each.value.store_id
    role = each.value.role
    member = each.value.member
}
