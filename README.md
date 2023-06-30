# ezTimeContainer
Podman container for [ezTime](https://github.com/ropg/ezTime) server component.
Based of my initial work in [my fork](https://github.com/TheGroundZero/ezTime) of the project.

Tiny container based of Alpine linux that will host the ezTime server serving timezone information on UDP port 2342.
Translates timezone strings like `Europe/London` into their POSIX notation.

Useful for when you want to run projects like [Clockwise](https://github.com/jnthas/clockwise/issues/39) fully locally.

To test:
```sh
nc -u <ip or domain name> 2342
Europe/London<ctrl+D>
```
