-- =========================================================================
-- Activity Tracker: Supabase PostgreSQL Schema & Realtime Setup
-- Execute this script in your Supabase Project: Dashboard > SQL Editor > New Query
-- =========================================================================

-- 1. PROFILES Table
CREATE TABLE IF NOT EXISTS public.profiles (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL,
    color TEXT DEFAULT 'purple',
    hobby TEXT DEFAULT '',
    avatartext TEXT DEFAULT '',
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 2. ACTIVITIES Table
CREATE TABLE IF NOT EXISTS public.activities (
    id TEXT PRIMARY KEY,
    profileid TEXT,
    title TEXT NOT NULL,
    category TEXT NOT NULL,
    categoryicon TEXT DEFAULT '🎯',
    date TEXT NOT NULL,
    time TEXT NOT NULL,
    duration TEXT DEFAULT '1h',
    notes TEXT DEFAULT '',
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- Index for speedy querying by profile and date
CREATE INDEX IF NOT EXISTS idx_activities_profileid ON public.activities(profileid);
CREATE INDEX IF NOT EXISTS idx_activities_date ON public.activities(date DESC);

-- 3. CATEGORIES Table (Custom categories created by Admin)
CREATE TABLE IF NOT EXISTS public.categories (
    id TEXT PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    icon TEXT DEFAULT '🎯',
    created_at TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

-- 4. Enable Row Level Security (RLS)
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.activities ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.categories ENABLE ROW LEVEL SECURITY;

-- 5. Drop existing policies to prevent conflicts
DROP POLICY IF EXISTS "Public access for profiles" ON public.profiles;
DROP POLICY IF EXISTS "Public access for activities" ON public.activities;
DROP POLICY IF EXISTS "Public access for categories" ON public.categories;

-- 6. Create permissive RLS policies for anonymous and authenticated access
CREATE POLICY "Public access for profiles"
ON public.profiles
FOR ALL
USING (true)
WITH CHECK (true);

CREATE POLICY "Public access for activities"
ON public.activities
FOR ALL
USING (true)
WITH CHECK (true);

CREATE POLICY "Public access for categories"
ON public.categories
FOR ALL
USING (true)
WITH CHECK (true);

-- 7. Add tables to Supabase Realtime publication
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' AND tablename = 'profiles'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.profiles;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' AND tablename = 'activities'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.activities;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' AND tablename = 'categories'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.categories;
    END IF;
END $$;

-- 8. MESSAGES Table (Private chat)
-- SECURITY: Unlike the tables above, messages are NOT publicly readable.
-- Only sessions that signed in with a password (authenticated role) can
-- read or write them. The public anon key used by the app gets nothing.
CREATE TABLE IF NOT EXISTS public.messages (
    id TEXT PRIMARY KEY,
    profileid TEXT NOT NULL,
    message TEXT NOT NULL,
    createdat TIMESTAMPTZ DEFAULT TIMEZONE('utc'::text, NOW())
);

CREATE INDEX IF NOT EXISTS idx_messages_createdat ON public.messages(createdat DESC);

ALTER TABLE public.messages ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS "Signed in users can read messages" ON public.messages;
DROP POLICY IF EXISTS "Signed in users can send messages" ON public.messages;

CREATE POLICY "Signed in users can read messages"
ON public.messages
FOR SELECT
TO authenticated
USING (true);

CREATE POLICY "Signed in users can send messages"
ON public.messages
FOR INSERT
TO authenticated
WITH CHECK (true);

CREATE POLICY "Signed in users can delete messages"
ON public.messages
FOR DELETE
TO authenticated
USING (true);

-- Add messages to Realtime publication (realtime still enforces RLS)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_publication_tables 
        WHERE pubname = 'supabase_realtime' AND tablename = 'messages'
    ) THEN
        ALTER PUBLICATION supabase_realtime ADD TABLE public.messages;
    END IF;
END $$;
