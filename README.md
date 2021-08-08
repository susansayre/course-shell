## HOw I created this repo

1. Choose template from Wowchemy and follow their directions to start and connect to GitHub
2. Clone to local machine using RStudio
3. Delete everything but .git, .gitignore, .Rproj in file browser
4. Open .Rproj and run ``blogdown::new_site(theme = "wowchemy/starter-hugo-project-documentation")
5. set blogdown.method to 'markdown' in .Rprofile
6. Add themes/ and .Rhistory to .gitignore
7. Commit all the changes except deleting .editorconfig, go.mod, go.sum
8. Customize course settings/structure

## How to use it
1. Create repo from template on GitHub
2. Clone to local machine
3. Copy themes folder from the local folder of this repo to the new repo.
4. Delete go.mod, go.sum, .editorconfig from local folder but DO NOT commit that change to git
5. Go to netlify and configure site to deploy from new repo