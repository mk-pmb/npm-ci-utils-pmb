
<!--#echo json="package.json" key="name" underline="=" -->
npm-ci-utils-pmb
================
<!--/#echo -->

<!--#echo json="package.json" key="description" -->
Helps me work with GitHub Actions and GitLab CI.
<!--/#echo -->



each_subpkg
-----------

Run a command in mostly all subdirectories that have a `package.json`,
except for paths that look like they should be left alone
(e.g. `node_modules` and symlinks onto external file systems).

```bash
# Example: Install all packages, then test all of them:
npm-ci-utils-pmb each_subpkg npm install . && \
npm-ci-utils-pmb each_subpkg npm test

# Or use a nifty shortcut for the above:
npm-ci-utils-pmb each_subpkg ci
```


<!--#toc stop="scan" -->



Known issues
------------

* Needs more/better tests and docs.




&nbsp;


License
-------
<!--#echo json="package.json" key=".license" -->
ISC
<!--/#echo -->
