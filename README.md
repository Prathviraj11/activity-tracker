# Activity Tracker (Web App & Supabase Cloud Sync)

A modern, responsive Activity Tracker web application designed for mobile and desktop, pre-configured with Supabase live multi-device synchronization and role-based Admin controls.

---

## 🚀 Quick Setup Guide

### Step 1: Set up Supabase Database (1 minute)
Before cloud sync can save data, your Supabase database needs the tables and permissions configured:
1. Log in to [Supabase Dashboard](https://supabase.com/dashboard).
2. Open your project (`aqdrigusidpfsqeidwux`).
3. Click **SQL Editor** in the left sidebar.
4. Click **New Query**, paste the contents of `supabase_schema.sql`, and click **Run**.
5. You should see `Success. No rows returned`. Your `profiles`, `activities`, and `categories` tables are now ready with real-time replication active!

---

### Step 2: Push to Git & Deploy to Vercel (1 minute)
1. Unzip `activity_tracker_production.zip`.
2. Push the files (`index.html`, `manifest.json`, `sw.js`, `vercel.json`, `supabase_schema.sql`, `README.md`) to your Git repository:
   ```bash
   git add .
   git commit -m "Update Activity Tracker with Supabase sync and admin permissions"
   git push origin main
   ```
3. Vercel will automatically detect the push and deploy your live site in seconds.

---

## 🛡️ Admin Controls & Permissions

| Action | Normal User | Admin Mode |
| :--- | :---: | :---: |
| **View Feed & Filter Activities** | ✅ Allowed | ✅ Allowed |
| **Log New Activity** | ✅ Allowed | ✅ Allowed |
| **Edit / Delete Activity** | ✅ Allowed | ✅ Allowed |
| **Switch Profiles** | ✅ Allowed | ✅ Allowed |
| **Add New Profile** | 🔒 Blocked (prompts Admin login) | ✅ Allowed |
| **Delete Profile** | 🔒 Hidden | ✅ Allowed |
| **Add Custom Category** | 🔒 Blocked (prompts Admin login) | ✅ Allowed |
| **Delete Custom Category** | 🔒 Hidden | ✅ Allowed |

- **Default Admin Password**: `admin123` (hidden from the UI; enter via the 🛡️ / 🔒 button in the header).
- **Change Password**: Once logged in as Admin, a secure field allows updating the PIN/password at any time.

---

## 📁 Included Files
- `index.html` - Complete single-page application with pre-configured Supabase keys & Material You styling.
- `supabase_schema.sql` - Copy-paste migration for Supabase SQL Editor.
- `vercel.json` - Clean routing configuration for Vercel static hosting.
- `manifest.json` - Web App Manifest for mobile PWA "Add to Home Screen" support.
- `sw.js` - Service worker for offline asset caching.
