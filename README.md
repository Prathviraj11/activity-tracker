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

## 🔐 App Lock & Private Messaging (Supabase Auth)

The app opens behind a full-screen password gate. The gate signs in to a **shared Supabase Auth account** — private messages are enforced **server-side with Row Level Security (RLS)**, so the message data is unreadable without a real sign-in (not just hidden in the UI).

### One-time Supabase setup (2 minutes)
1. **Dashboard → Authentication → Sign In / Providers → Email**: make sure Email is enabled and **Confirm email is OFF**.
2. **Dashboard → Authentication → Users → Add user** — create the two chat accounts (any password of your choice, 6+ chars):
   - `praathviraj@gmail.com` → chats as **Prathvi**
   - `shwetas200020@gmail.com` → chats as **Shwetee**
3. **Dashboard → SQL Editor**: re-run the full contents of `supabase_schema.sql` (adds the private `messages` table with RLS; safe to re-run).
4. No app configuration needed — each person enters their own email on the Messages tab.

### Daily use
- **Unlock website**: local app password only (default `myfrutvi`) — fast, no email needed.
- **Messages**: open the Messages tab → enter the shared account **email + password** → **🔓 Show Messages** loads the chat (Supabase session kept until you re-lock with the 🔒 button). All messages are visible to anyone signed in.
- **Chat**: pick "Sending as" profile, bubbles sync live across devices.
- **Auto-delete**: the 🗑 toggle (on by default) automatically deletes messages older than 1 month whenever the Messages tab loads.
- **Re-lock**: 🔒 button in the header (clears the sign-in session too; passwords required again).
- **Change app password**: Admin panel (🛡️) → *Change App Open Password*.
- Unlock lasts until the browser/app session is closed (sessionStorage).

> Note: Free plan projects pause after 1 week without activity — open the app weekly, or press **Restore** in the Supabase dashboard if messages stop syncing.

---

## 📁 Included Files
- `index.html` - Complete single-page application with pre-configured Supabase keys & Material You styling.
- `supabase_schema.sql` - Copy-paste migration for Supabase SQL Editor.
- `vercel.json` - Clean routing configuration for Vercel static hosting.
- `manifest.json` - Web App Manifest for mobile PWA "Add to Home Screen" support.
- `sw.js` - Service worker for offline asset caching.
