# psy611
Materials for PSY 611: Data Analysis I

# TA Guide: Updating Weekly Lab Pages (R Markdown Website)

This guide covers how to:

1. Pull the latest site
2. Edit/add a lab `.Rmd` and update the navbar
3. Render the site locally
4. Push your changes to GitHub

---

## 0) One-time checks (so you know how the site builds)

* Open `_site.yml` and note:

  * `output_dir: "."` → HTML files are written next to their `.Rmd` (e.g., `labs/lab-6.Rmd` → `labs/lab-6.html`).
  * Navbar structure: “Labs” uses explicit `href:` entries like `labs/lab-1.html`, `labs/lab-2_student.html`, etc. You must add your new lab to this list to expose it in the nav.
  * `output: html_document: self_contained: no` with `lib_dir: site_libs` → shared JS/CSS go in `site_libs/`. Commit any changes there if they’re created/updated.

---

## 1) Pull the most recent version

**RStudio (Git pane):**

1. Open the project in RStudio.
2. Git pane → **Pull**.

**Command line:**

```bash
git checkout main
git pull origin main
# (recommended) work on a branch
git checkout -b lab-XX-update
```

---

## 2) Make your lab changes

### 2.1 Edit or create the lab file

* Labs live in `labs/` and are single files named like `lab-1.Rmd`, `lab-2_student.Rmd`, etc.
* To create a new lab (example: Lab 10):

  * Create `labs/lab-10.Rmd` with a minimal header like:

    ```yaml
    ---
    title: "Lab 10: <Short Title>"
    output:
      html_document:
        toc: true
        toc_depth: 3
        number_sections: false
    ---
    ```

  * Add your content below the header (use relative paths for any data/images).
* Match the existing naming style. If earlier weeks use suffixes (e.g., `_student`, `_ist`), keep your naming consistent.

### 2.2 Add the lab to the navbar

* Open `_site.yml`, find the **Labs** menu block, and add a new entry that exactly matches your intended output filename:

  ```yaml
  - text: "Lab 10"
    href: "labs/lab-10.html"
  ```

* Keep indentation consistent (YAML is whitespace-sensitive).

* If existing entries use a different label format (e.g., “Lab 2”), copy that style.

### 2.3 Save your changes

* Save `labs/lab-XX.Rmd` and `_site.yml`.

---

## 3) Render the site locally

**Option A — Render just your lab file (fastest while drafting):**

* In RStudio, open `labs/lab-XX.Rmd` and click **Knit**; or run:

  ```r
  rmarkdown::render("labs/lab-XX.Rmd")
  ```
* This produces `labs/lab-XX.html`. Open it to check content.

**Option B — Build the whole site (updates navbar + all pages):**

* In RStudio: **Build** → **Build Website** (or **Ctrl/Cmd + Shift + B**).
* Or in the R console:

  ```r
  rmarkdown::render_site()
  ```

Check that:

* The **navbar** shows your new lab under “Labs”.
* The link points to the correct HTML (`labs/lab-XX.html`).
* Images/data load and code chunks run.

---

## 4) Commit & push to GitHub

**RStudio (Git pane):**

1. Stage changed files (e.g., `labs/lab-XX.Rmd`, `_site.yml`, and any newly created `labs/lab-XX.html` plus updates to `site_libs/` if present).
2. **Commit** with a clear message, e.g., `Add Lab XX and navbar entry; render site`.
3. **Push** your branch. Open a Pull Request on GitHub if you’re using branches.

**Command line:**

```bash
git add labs/lab-XX.Rmd _site.yml
# If new/updated HTML or site_libs were generated:
git add labs/lab-XX.html site_libs/ || true

git commit -m "Add Lab XX and navbar entry; render site"
git push -u origin lab-XX-update
```

If using a branch, open a Pull Request on GitHub, add a short description, and request review.

Deployment notes:

* If GitHub Pages serves from the repo root (and you commit the rendered `.html` files), merging to `main` updates the live site.
* If CI/Netlify is used, merging usually triggers a deploy automatically.

---

## Troubleshooting & tips

* **Navbar link 404:** Ensure the `href:` exactly matches the rendered filename (e.g., `labs/lab-2_student.html`, not `labs/lab-2.html`).
* **YAML indentation errors:** Recheck spacing in `_site.yml` and the Rmd header.
* **Missing assets:** With `self_contained: no`, make sure `site_libs/` and any referenced images/data are tracked and pushed if they’re new/changed.
* **Consistent naming:** Follow existing patterns in `_site.yml` so the nav stays orderly and predictable.

---

## Quick reference (CLI)

```bash
# 1) Pull latest
git checkout main
git pull origin main
git checkout -b lab-XX-update

# 2) Edit
#   - labs/lab-XX.Rmd
#   - _site.yml (add Labs menu item pointing to labs/lab-XX.html)

# 3) Render
R -q -e "rmarkdown::render('labs/lab-XX.Rmd')"
R -q -e "rmarkdown::render_site()"

# 4) Commit & push
git add labs/lab-XX.Rmd _site.yml labs/lab-XX.html site_libs/ || true
git commit -m "Add Lab XX and navbar entry; render site"
git push -u origin lab-XX-update
```

