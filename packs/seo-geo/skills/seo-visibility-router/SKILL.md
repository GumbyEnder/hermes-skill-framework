name: seo-visibility-router
description: >
  Route SEO, GEO, and search visibility requests to the right workflow.
  Use this skill when the user asks about keyword research, content optimization,
  backlink strategy, rank tracking, technical SEO, local SEO, Open Graph/social
  previews, AI search visibility, citation monitoring, or general SEO tool choice.
metadata:
  version: 1.0.0
  origin: inspired by serpapi/awesome-seo-tools
  license: see upstream references before reuse
---

# SEO Visibility Router

## What this skill does

This skill does one job: figure out which SEO or GEO path the user is actually asking for, then send the request to the right reference or follow-up skill.

Think of it like a triage desk.

## Use this when

- the user says “I need SEO help” and the real problem is unclear
- the request could be keyword, content, technical, local, or authority work
- the user asks about AI search visibility, GEO, or brand mentions in answer engines
- the user wants a recommendation on which SEO tool or workflow to use

## Routing rules

### Keyword research
Use when the user wants:
- keyword ideas
- clustering
- intent grouping
- topic expansion
- content opportunities

See: `references/keyword-research.md`

### Content optimization
Use when the user wants:
- page rewrites
- content briefs
- search-intent alignment
- on-page improvements
- AI-search-friendly content structure

See: `references/content-optimization.md`

### Backlink / authority
Use when the user wants:
- link building
- backlink analysis
- authority planning
- competitive link gaps

See: `references/backlink-analysis.md`

### Rank tracking
Use when the user wants:
- ranking checks
- movement analysis
- keyword visibility monitoring
- SERP trend reporting

See: `references/rank-tracking.md`

### Technical SEO
Use when the user wants:
- crawl/index issues
- site speed
- render problems
- structured data
- canonicals
- sitemap/robots questions

See: `references/technical-seo.md`

### Local SEO
Use when the user wants:
- map pack visibility
- local citations
- location pages
- service-area SEO
- reviews and business profile work

See: `references/local-seo.md`

### Social / Open Graph
Use when the user wants:
- share preview optimization
- OG image strategy
- title/description cards
- social click-through improvement

See: `references/social-og.md`

### AI search visibility / GEO
Use when the user wants:
- GEO strategy
- AI answer visibility
- citation tracking
- brand mention monitoring in LLM outputs
- optimization for AI search surfaces

See: `references/ai-search-visibility.md`

### Tool selection
Use when the user wants:
- help choosing an SEO tool
- a category map of the SEO landscape
- a recommendation for which workflow comes first

See: `references/all-in-one.md`
See also: `references/misc-tools.md`

## Response style

Be direct.
State the likely category first.
Then give the best next action.
If the request is ambiguous, ask one tight clarifying question instead of guessing.

## Output shape

When routing, return:
1. likely category
2. why it matched
3. next workflow reference or skill
4. any obvious tool suggestions if relevant
