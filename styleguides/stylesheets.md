Stylesheet Style Guidelines
===========================

``
WIP
``

## General Coding Style
- Use soft-tabs with a two space indent.
- Put spaces after `:` in property declarations.
- Put spaces before `{` in rule declarations.
- Use hex color codes `#fd0` unless using rgba.

		.style-format {
			border: 1px solid #d00;
			color: #d00;
			background: #fd0;
		}
		
tips:
- use [EditorConfig](http://editorconfig.org/) to keep indentation consistent

### Comments
Separate discrete sections of stylesheets with section comment blocks.

Example:
``
/* -----------------------------------
 	 		Section comment block
-------------------------------------- */
 	
/* Basic comment */
``
		
		
## SASS Style
- Any `$variable`, `@mixin` or `%silent-extend` that is used more than once should be placed in an appropriate partial
- Stay away from using id’s or deep nesting when creating any re-usable styles. This can make the specificity hard to overcome in other places.


## File Organization
In general, the stylesheet file organization should look something like this:

``
css
|—— lib
|   |—— normalize.scss
|   |—— $colors.scss
|   |—— @mixins.scss
|   |—— %extends.scss
|—— pages
|   |—— page-specific.scss
|   |—— page-specific.scss
|—— _buttons.scss
|—— _common.scss
|—— _grid.scss
|—— _media-queries.scss
|—— site.scss
``
	
Try and seperate partials into those that do, and those that don’t render anything. For those that don’t, prepend the filename with a `$`, `@`, or `%` to indicate it can safely be imported without repeating/generating content.

Each page will typically include the `site.css` and a `page-specific.css` for page specific styles. If something is repeated on page specific styles, move it to the `site.css`

	
## Pixels vs. Ems
Use a `px` font size declaration on the body element, and `em` after that. Any property that relates to type ( margin on an `h1` for example ) should be declared with `em`. Unit-less `line-height` is preferred because it does not inherit a percentage value of its parent element, but instead is based on a multiplier of the `font-size`.


## Specificity (classes vs. ids)
Be very particular when deciding to use an id as a style hook. They should typically only be used on elements where outside styles should generally be ignored ( header, footer, modals ) or for page-specific styles.


## Namespacing
Blah, blah, blah