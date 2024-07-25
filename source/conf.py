# Configuration file for the Sphinx documentation builder.

# -- Project information

project = 'Digitális bölcsészet alapok'
copyright = '2024, ELTE-DH. Az anyag a Creative Commons, Nevezd meg! - Így add tovább! CC-BY-SA 4.0 Nemzetközi Licenc feltételeinek megfelelően, permalinkes (kattintható és az adott cikkre mutató) forrásmegjelöléssel szabadon felhasználható'
author = 'ELTE-DH'

release = '1.0.0'
version = '1.0.0'

# -- General configuration

extensions = [
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
]

intersphinx_mapping = {
    'python': ('https://docs.python.org/3/', None),
    'sphinx': ('https://www.sphinx-doc.org/en/master/', None),
}
intersphinx_disabled_domains = ['std']

templates_path = ['_templates']

# -- Options for HTML output

html_theme = 'sphinx_rtd_theme'

# -- Options for EPUB output
epub_show_urls = 'footnote'
