# vim-goimpl

`:GoImpl` command for Go

## Usage

When you have an interface

```go
type Foo interface {
     DoSomething()
}
```

Implement struct of struct/interface under the cursor

```
:GoImpl
```

```go
type FooImpl struct {
}

type (f *FooImpl) DoSomething() {
    panic("not implemented") // TODO: Implement
}
```

Implement struct of struct/interface with given interface

```
:GoImpl io.Reader
```

```go
func (r *Reader) Read(p []byte) (n int, err error) {
	panic("not implemented") // TODO: Implement
}
```

Implement struct of struct/interface with given interface and given name

```
:GoImpl io.Reader bar
```

```go
type Bar struct {
}

func (b *Bar) Read(p []byte) (n int, err error) {
	panic("not implemented") // TODO: Implement
}
```

## Installation


For [vim-plug](https://github.com/junegunn/vim-plug) plugin manager:

```viml
Plug 'mattn/vim-goimpl'
```

## License

MIT

## Author

Yasuhiro Matsumoto (a.k.a. mattn)
