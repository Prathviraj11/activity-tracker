# Activity Tracker 🚀

A modern, responsive personal and group activity tracker with real-time cloud sync, PWA mobile installation, role-based admin controls, and custom category management.

## ⚡ Hosting with Vercel + Git (Recommended)

Since your Vercel account is already connected to Git, this is the easiest and most powerful way to host:

1. **Create a Git Repository**:
   - Go to [GitHub New Repository](https://github.com/new) (or GitLab / Bitbucket).
   - Name it `activity-tracker` and click **Create repository**.
2. **Upload / Push the Files**:
   - Upload the files from this folder (`index.html`, `manifest.json`, `sw.js`, `vercel.json`, `supabase_schema.sql`).
3. **Import into Vercel**:
   - Go to [vercel.com/new](https://vercel.com/new).
   - Under "Import Git Repository", find `activity-tracker` and click **Import**.
   - Keep default settings (Framework: Other) and click **Deploy**.
4. **Done!** Within ~10 seconds, your site is live at `https://activity-tracker-<yourname>.vercel.app`.
   - Every time you push a change to Git, Vercel automatically deploys it!

---

## 🗄️ Database Setup (Supabase)

Your app is already pre-configured with your Supabase credentials!
Just make sure you've executed the database tables once in Supabase:
1. In your [Supabase Dashboard](https://supabase.com), click the **SQL Editor** icon (`>_`).
2. Click **New query**, paste the entire contents of `supabase_schema.sql`, and click **Run**.
