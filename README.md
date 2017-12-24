# Workaround for Shadow Tactics: Blades of the Shogun crash with newer libxcb

On newer Linux distributions, Shadow Tactics: Blades of the Shogun
crashes on startup with an xcb assertion failure. This is a workaround.

## Bug description

The game crashes, before the point at which the white screen with
logos would normally appear. The log file
`~/.config/unity3d/Daedalic Entertainment GmbH/Shadow Tactics Blades of the Shogun/Player.log`
starts with this:

```
[xcb] Unknown sequence number while processing queue
[xcb] Most likely this is a multi-threaded client and XInitThreads has not been called
[xcb] Aborting, sorry about that.
Shadow Tactics: ../../src/xcb_io.c:259: poll_for_event: Assertion `!xcb_xlib_threads_sequence_lost' failed.
```

## Workaround

Compile `32/preload-xinitthreads.so` from this repository and copy it
somewhere convenient. Then change the launch options for this game in Steam to:

```
env LD_PRELOAD="/path/to/preload-xinitthreads.so:$LD_PRELOAD" %command%
```

## Proper fix

The game developers should be able to fix this by arranging for
`XInitThreads()` to be called before any other X11 APIs. Rebuilding the
game binary with a newer version of Unity might already do that. Worst
case, the game binary could be replaced by a shell script that sets
`LD_PRELOAD` to preload this workaround, then execs the binary produced
by Unity.

Developers from Daedalic/Mimimi are very welcome to include this preload
hack in their game, if it would help.

## Disclaimers

I am not affiliated with Daedalic Entertainment or Mimimi Productions.
If you have encountered other bugs in this game, I cannot solve them.

This workaround is provided with no warranty of any kind.
