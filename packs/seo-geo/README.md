This pack gives Hermes a practical, model-agnostic way to work through SEO, GEO, and search visibility tasks.

It is not trying to be a giant tools directory. It is a routing layer for real work:
- figure out what kind of search problem the user actually has
- point the request at the right skill
- keep the workflow usable across Claude, OpenAI, and local models
- keep the output useful for a human who needs to act on it

## Why this pack exists

SEO work breaks down into a handful of repeatable buckets:
- keyword research
- content optimization
- backlink / authority work
- rank tracking
- technical SEO
- local SEO
- social / Open Graph previews
- AI search visibility and GEO-style monitoring

A lot of SEO tool lists are just catalogs. Those are useful, but they are not enough for an agent.
This pack is meant to turn the catalog into a workflow.

## Source inspiration

This pack was shaped partly by a curated essential SEO tools taxonomy and the category structure of SerpApi’s SEO tools index.

That map is useful for understanding the SEO tool landscape, especially where it starts to touch AI search / GEO / visibility monitoring.
Before copying any text or content from upstream sources, verify the license and keep attribution clean.

## Pack layout

- `skills/seo-visibility-router/SKILL.md` — front door for SEO/GEO requests
- `skills/seo-visibility-router/references/` — category-based references and routing notes

## What this pack should do well

- route the request to the right SEO category
- keep Hermes model-agnostic
- produce concise, practical next steps
- support modern AI search visibility work, not just classic SERP SEO
- make it obvious when to use a human tool like Ahrefs, Search Console, or a crawler

## What this pack should not do

- hard-code one vendor into the skill logic
- turn the pack into a copy of an SEO tools directory
- assume SEO always means traditional Google SERPs
- bury the workflow under tool spam

## First skill

The first skill in this pack is `seo-visibility-router`.
It is the entry point when Hermes needs to decide which SEO/GEO path to take.
