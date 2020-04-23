# Game of Life

Rules applied at each stages:

1. Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
2. Any live cell with two or three live neighbours lives on to the next generation.
3. Any live cell with more than three live neighbours dies, as if by overpopulation.
4. Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

## Usage

Clone the repo, cd into the project and run:

`ruby play.rb`

By default, uses the JOHN constant, to mimic the xkcd comic: https://xkcd.com/2293/

### Examples

You can pass an argument from the list of constants in Pattern. Examples taken from: https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life

- `ruby play.rb blinker`
- `ruby play.rb toad`
- `ruby play.rb beacon`
- `ruby play.rb pulsar`
- `ruby play.rb penta_decathlon`
- `ruby play.rb john`
- `ruby play.rb shopify`

## Thanks

Jessica Xie for the initial pairing and idea

- `ruby play.rb shopify`

## Improvements

This was a fun mini-project. Here is a list of improvements that I might not do.

1. Using figlet, I generated the `shopify` constant - it would be cool if it could take the word and generate the array if no constant is found.

`figlet -f banner $1 | sed -e"s/#/1,/g" | sed -e"s/ /0,/g" | xclip -selection clipboard;`

(Needs a little vim sugar to tidy up)

2. The GameOfLife class takes an array, but I don't know how to pass an array to it when running `ruby file/path`
3. Lives defaults to 1000, make that optional
4. Code improvements - for example, we pass around row/column number a lot..

## Contact

Notice anything? Any comments or suggestions?

Twitter: @JalisoCSP

Github: JalisoCSP

Website: https://craigpetterson.co.uk
