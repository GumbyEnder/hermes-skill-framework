# Medusa Admin API — Endpoint Reference

Complete catalog of Medusa v2 Admin REST API endpoints supported by this skill.
Base URL: `{MEDUSA_ADMIN_URL}/admin`

All requests require `Authorization: Bearer {token}` header.

---

## Authentication

### Get JWT Token
```
POST /admin/auth/token
Content-Type: application/json

Request:  { "email": "admin@store.com", "password": "..." }
Response: { "token": "eyJhbGciOiJIUzI1NiIs..." }
```

Use when `MEDUSA_ADMIN_TOKEN` is not set but `MEDUSA_ADMIN_EMAIL` +
`MEDUSA_ADMIN_PASSWORD` are configured.

---

## Store

### Get Store Details
```
GET /admin/store

Response: {
  "store": {
    "id": "store_01H...",
    "name": "By Night Studios",
    "default_currency_code": "usd",
    "default_region_id": "reg_01H...",
    "default_sales_channel_id": "sc_01H...",
    "currencies": [{ "code": "usd", ... }],
    "regions": [{ "id": "reg_01H...", "name": "US", ... }]
  }
}
```

---

## Products

### List Products
```
GET /admin/products?limit=50&offset=0&q=searchterm&status[]=published

Query params:
  limit       Number of results (default 50, max 200)
  offset      Pagination offset
  q           Full-text search across title + handle
  status[]    Filter by status: draft | published | rejected
  collection_id[]  Filter by collection
  created_at   Date range filter (JSON: {"$gte":"2024-01-01"})

Response: {
  "products": [
    {
      "id": "prod_01H...",
      "title": "Clan Pendant",
      "handle": "clan-pendant",
      "status": "published",
      "thumbnail": "https://...",
      "variants": [{ "id": "var_01H...", "title": "Gold", ... }],
      "options": [{ "title": "Color", "values": ["Gold","Silver"] }],
      "created_at": "2024-03-15T10:30:00Z",
      "updated_at": "2024-03-15T10:30:00Z"
    }
  ],
  "count": 158,
  "offset": 0,
  "limit": 50
}
```

### Get Product
```
GET /admin/products/:id

Response: Single product object (same shape as list item, with full details).
Includes: variants with prices, options, images, collection memberships.
```

### Create Product
```
POST /admin/products
Content-Type: application/json

Request: {
  "title": "Dark Clan T-Shirt",
  "handle": "dark-clan-tshirt",      // Optional, auto-generated from title
  "status": "published",              // draft | published
  "options": [{ "title": "Size", "values": ["S","M","L","XL"] }],
  "variants": [
    {
      "title": "S",
      "options": { "Size": "S" },
      "prices": [{ "currency_code": "usd", "amount": 2999 }]
    }
  ],
  "images": [{ "url": "https://..." }],
  "collection_ids": ["pcol_01H..."]
}

Response: Created product object with generated id.
```

Amount is in cents: `$29.99` = `2999`.

### Update Product
```
POST /admin/products/:id
Content-Type: application/json

Request: { "title": "Updated Title", "status": "published" }

Response: Updated product object.
```

### Delete Product
```
DELETE /admin/products/:id

Response: { "id": "prod_01H...", "object": "product", "deleted": true }
```

⚠️ Requires `confirm=true` to prevent accidental deletion.

---

## Orders

### List Orders
```
GET /admin/orders?limit=50&offset=0&status[]=pending&q=searchterm

Query params:
  limit         Number of results (default 50, max 200)
  offset        Pagination offset
  status[]      Filter: pending | completed | archived | canceled | requires_action
  q             Search across display_id, email, shipping address
  created_at     Date range (JSON: {"$gte":"2024-03-01"})
  fields         Comma-separated fields to return (for performance)

Response: {
  "orders": [
    {
      "id": "ord_01H...",
      "display_id": 1042,
      "status": "pending",
      "email": "customer@example.com",
      "currency_code": "usd",
      "total": 5497,                    // In cents: $54.97
      "items": [
        {
          "id": "item_01H...",
          "title": "Clan Pendant",
          "quantity": 2,
          "unit_price": 2499,
          "total": 4998
        }
      ],
      "shipping_address": { "first_name": "...", ... },
      "created_at": "2024-03-15T14:22:00Z",
      "fulfillment_status": "not_fulfilled",
      "payment_status": "captured"
    }
  ],
  "count": 47,
  "offset": 0,
  "limit": 50
}
```

### Get Order
```
GET /admin/orders/:id

Response: Single order with full details (items, shipping, payment, timeline).
```

### Fulfill Order
```
POST /admin/orders/:id/fulfillment
Content-Type: application/json

Request: {
  "items": [
    { "id": "item_01H...", "quantity": 2 }
  ],
  "no_notification": false,
  "metadata": { "fulfilled_by": "Hermes Agent" }
}

Response: { "order": { ... updated order with fulfillment ... } }
```

⚠️ Requires `confirm=true` to prevent accidental fulfillment.

### Cancel Order
```
POST /admin/orders/:id/cancel

Response: { "order": { ... order with status "canceled" ... } }
```

⚠️ Requires `confirm=true`. Only pending orders can be canceled.

### Archive Order
```
POST /admin/orders/:id/archive

Response: { "order": { ... order with status "archived" ... } }
```

### Add Note to Order
```
POST /admin/orders/:id/notes
Content-Type: application/json

Request: { "value": "Customer called — ship ASAP" }
```

---

## Customers

### List Customers
```
GET /admin/customers?limit=50&offset=0&q=searchterm

Response: {
  "customers": [
    {
      "id": "cus_01H...",
      "email": "customer@example.com",
      "first_name": "Jane",
      "last_name": "Doe",
      "has_account": true,
      "created_at": "2024-01-10T08:00:00Z"
    }
  ],
  "count": 32,
  "offset": 0,
  "limit": 50
}
```

### Get Customer
```
GET /admin/customers/:id

Response: Full customer with order history, addresses, groups.
```

---

## Collections

### List Collections
```
GET /admin/collections?limit=50

Response: {
  "collections": [
    {
      "id": "pcol_01H...",
      "title": "Clan Pins",
      "handle": "clan-pins",
      "products": [{ "id": "prod_01H...", ... }]
    }
  ],
  "count": 8,
  "offset": 0,
  "limit": 50
}
```

### Get Collection
```
GET /admin/collections/:id

Response: Collection with product list.
```

### Add Products to Collection
```
POST /admin/collections/:id/products
Content-Type: application/json

Request: { "product_ids": ["prod_01H...", "prod_02X..."] }
```

### Remove Products from Collection
```
DELETE /admin/collections/:id/products
Content-Type: application/json

Request: { "product_ids": ["prod_01H..."] }
```

---

## Inventory

### List Inventory Items
```
GET /admin/inventory-items?variant_id=var_01H...

Query params:
  variant_id[]   Filter by variant(s)
  limit/offset   Pagination

Response: {
  "inventory_items": [
    {
      "id": "iitem_01H...",
      "sku": "CP-GLD-001",
      "title": "Clan Pendant - Gold",
      "requires_shipping": true,
      "stocked_quantity": 42,
      "reserved_quantity": 3,
      "available_quantity": 39                // stocked - reserved
    }
  ],
  "count": 1
}
```

### Update Inventory Level
```
POST /admin/inventory-items/:id
Content-Type: application/json

Request: { "stocked_quantity": 50 }

Response: Updated inventory item.
```

⚠️ Requires `confirm=true` — this directly adjusts stock.

---

## Regions

### List Regions
```
GET /admin/regions

Response: {
  "regions": [
    {
      "id": "reg_01H...",
      "name": "US",
      "currency_code": "usd",
      "countries": [{ "iso_2": "us", "name": "United States" }]
    }
  ],
  "count": 1
}
```

---

## Common HTTP Status Codes

| Code | Meaning | Typical cause |
|---|---|---|
| 200 | Success | — |
| 201 | Created | Product/order created |
| 400 | Bad request | Invalid payload, missing required field |
| 401 | Unauthorized | Invalid/expired token |
| 404 | Not found | Wrong ID or endpoint |
| 409 | Conflict | Duplicate handle, product already fulfilled |
| 422 | Validation error | Payload failed validation rules |
| 429 | Rate limited | Too many requests |

---

## Pagination Pattern

All list endpoints follow the same pattern:

```
GET /admin/{resource}?limit=50&offset=0
→ Response: { "{resources}": [...], "count": N, "offset": 0, "limit": 50 }
```

To fetch all records:
```
offset=0  → returns items 1-50
offset=50 → returns items 51-100
...until count is reached.
```

Max `limit` is 200.
