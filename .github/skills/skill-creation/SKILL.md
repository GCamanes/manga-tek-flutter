---
name: skill-creation
description: Rules for creating or editing agent skills in this project. Use when adding, modifying, or reviewing any skill file.
---

## File location

```
.github/skills/<topic-kebab-case>/SKILL.md
```

---

## Frontmatter

```yaml
---
name: <topic-kebab-case>
description: <one sentence>. Use when <precise trigger condition>.
---
```

- `description` must be specific enough that the skill is only loaded when relevant.
- Bad: `"Use when working on the app."` — too broad, wastes tokens on unrelated tasks.
- Good: `"Use when adding routes, navigation helpers, or modifying the router."`

---

## Content rules

| Rule | Detail |
|------|--------|
| **Short** | Target ≤ 80 lines. Hard cap: 150 lines. |
| **Tables over prose** | Use tables for mappings, file lists, option comparisons. |
| **Code blocks** | Show patterns with minimal but complete examples. |
| **No rationale** | Omit "why" explanations — rules only. |
| **No repetition** | Don't restate rules already in another skill; reference it instead. |
| **No filler** | No intros, no conclusions, no "note that…" sentences. |
| **No correct/incorrect pattern** | Express rules as direct statements — never use ✅/❌ blocks. |

---

## Splitting skills

Split into separate files when:
- A skill exceeds ~100 lines.
- Two concerns have different trigger conditions (different "Use when…").
- A section is only relevant for a subset of tasks covered by the skill.

Example split: `architecture-data` + `architecture-domain` + `architecture-presentation` instead of one large `architecture` skill.

---

## Checklist before saving

- [ ] Frontmatter `description` is specific
- [ ] File is ≤ 150 lines
- [ ] No prose paragraphs — use tables or bullets
- [ ] No content duplicated from another skill
