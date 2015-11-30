var make = function make(localRuntime) {
    return function () {
        var Taskø1 = Elm.Native.Task.make(localRuntime);
        var Utilsø1 = Elm.Native.Utils.make(localRuntime);
        var Signalø1 = Elm.Native.Signal.make(localRuntime);
        var Tuple0ø1 = (Utilsø1 || 0)['Tuple0'];
        return (function () {
            sanitize(localRuntime, 'Native', 'Streams');
            return localRuntime.Native.Streams.values ? localRuntime.Native.Streams.values : localRuntime.Native.Streams.values = {
                'logBuffer': F2(function (encoding, chunk) {
                    return (function () {
                        console.log(chunk ? chunk.toString(encoding) : chunk);
                        return Taskø1.succeed(Tuple0ø1);
                    })();
                }),
                'on': F5(function (Left, Right, eventName, stream, f) {
                    return (function () {
                        stream.on(eventName, function (chunk) {
                            return Taskø1.perform(f(typeof(chunk) == 'string' ? Left(chunk) : Right(chunk)));
                        });
                        return Taskø1.succeed(Tuple0ø1);
                    })();
                }),
                'isPaused': oo.get0('isPaused', Taskø1),
                'pause': oo.method0('pause', Taskø1, Tuple0ø1),
                'pipe': F2(oo.method2('pipe', Taskø1, Tuple0ø1)),
                'read': F5(function (Left, Right, Just, Nothing, stream) {
                    return Taskø1.succeed(function () {
                        var xø1 = stream.read();
                        return xø1 ? Just('string' == typeof(xø1) ? Left(xø1) : Right(xø1)) : Nothing;
                    }.call(this));
                }),
                'readSize': F6(function (Left, Right, Just, Nothing, stream, size) {
                    return Taskø1.succeed(function () {
                        var xø1 = stream.read(size);
                        return xø1 ? Just('string' == typeof(xø1) ? Left(xø1) : Right(xø1)) : Nothing;
                    }.call(this));
                }),
                'resume': oo.method0('resume', Taskø1, Tuple0ø1),
                'setEncoding': F2(oo.method1('setEncoding', Taskø1, Tuple0ø1)),
                'unpipe': F2(oo.method1('unpipe', Taskø1, Tuple0ø1)),
                'unpipeAll': oo.method0('unpipe', Taskø1, Tuple0ø1),
                'unshift': F2(oo.method1('unshift', Taskø1, Tuple0ø1)),
                'cork': oo.method0('cork', Taskø1, Tuple0ø1),
                'endString': F3(oo.method2cb('end', Taskø1, Tuple0ø1)),
                'endBuffer': F2(oo.method1cb('end', Taskø1, Tuple0ø1)),
                'setDefaultEncoding': F2(oo.method1('setDefaultEncoding', Taskø1, Tuple0ø1)),
                'uncork': oo.method0('uncork', Taskø1, Tuple0ø1),
                'writeString': F2(oo.method1cb('write', Taskø1, Tuple0ø1)),
                'writeBuffer': F3(oo.method2cb('write', Taskø1, Tuple0ø1)),
                'writeStringSignal': F3(function (encoding, signal, stream) {
                    return (function () {
                        Signalø1.output('write-stream-buffer', function (chunk) {
                            return chunk ? stream.write(chunk, encoding) : void 0;
                        }, signal);
                        return Taskø1.succeed(Tuple0ø1);
                    })();
                }),
                'writeBufferSignal': F2(function (signal, stream) {
                    return (function () {
                        Signalø1.output('write-stream-buffer', function (chunk) {
                            return chunk ? stream.write(chunk) : void 0;
                        }, signal);
                        return Taskø1.succeed(Tuple0ø1);
                    })();
                })
            };
        })();
    }.call(this);
};
sanitize(Elm, 'Native', 'Streams');
Elm.Native.Streams.make = make;
//# sourceMappingURL=data:application/json;base64,eyJ2ZXJzaW9uIjozLCJzb3VyY2VzIjpbImFub255bW91cy53aXNwIl0sIm5hbWVzIjpbIm1ha2UiLCJsb2NhbFJ1bnRpbWUiLCJUYXNrw7gxIiwiRWxtIiwiTmF0aXZlLlRhc2subWFrZSIsIlV0aWxzw7gxIiwiTmF0aXZlLlV0aWxzLm1ha2UiLCJTaWduYWzDuDEiLCJOYXRpdmUuU2lnbmFsLm1ha2UiLCJUdXBsZTDDuDEiLCJzYW5pdGl6ZSIsIk5hdGl2ZS5TdHJlYW1zLnZhbHVlcyIsIkYyIiwiZW5jb2RpbmciLCJjaHVuayIsImNvbnNvbGUiLCJsb2ciLCJ0b1N0cmluZyIsInN1Y2NlZWQiLCJGNSIsIkxlZnQiLCJSaWdodCIsImV2ZW50TmFtZSIsInN0cmVhbSIsImYiLCJvbiIsInBlcmZvcm0iLCJ0eXBlb2YiLCJvbyIsImdldDAiLCJtZXRob2QwIiwibWV0aG9kMiIsIkp1c3QiLCJOb3RoaW5nIiwieMO4MSIsInJlYWQiLCJGNiIsInNpemUiLCJtZXRob2QxIiwiRjMiLCJtZXRob2QyY2IiLCJtZXRob2QxY2IiLCJzaWduYWwiLCJvdXRwdXQiLCJ3cml0ZSIsIk5hdGl2ZS5TdHJlYW1zLm1ha2UiXSwibWFwcGluZ3MiOiJBQUFBLElBQU9BLElBQUEsR0FBUCxTQUFPQSxJQUFQLENBQ0dDLFlBREgsRUFDaUI7QUFBQSxXLFlBQ2Q7QUFBQSxZQUFBQyxNLEdBQVFDLEdBQUEsQ0FBSUMsZ0JBQUwsQ0FBdUJILFlBQXZCLENBQVA7QUFBQSxRQUNBLElBQUFJLE8sR0FBUUYsR0FBQSxDQUFJRyxpQkFBTCxDQUF1QkwsWUFBdkIsQ0FBUCxDQURBO0FBQUEsUUFFQSxJQUFBTSxRLEdBQVFKLEdBQUEsQ0FBSUssa0JBQUwsQ0FBd0JQLFlBQXhCLENBQVAsQ0FGQTtBQUFBLFFBR0EsSUFBQVEsUSxJQUFnQkosTyxNQUFULEMsUUFBQSxDQUFQLENBSEE7QUFBQSxRQUlELE8sYUFDRTtBQUFBLFlBQUNLLFFBQUQsQ0FBVVQsWUFBVixFLFFBQUEsRSxTQUFBO0FBQUEsWUFDQSxPQUFJQSxZQUFBLENBQWFV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bWVdIChsZXRcbiAgW1Rhc2sgICAoRWxtLk5hdGl2ZS5UYXNrLm1ha2UgIGxvY2FsUnVudGltZSlcbiAgIFV0aWxzICAoRWxtLk5hdGl2ZS5VdGlscy5tYWtlIGxvY2FsUnVudGltZSlcbiAgIFNpZ25hbCAoRWxtLk5hdGl2ZS5TaWduYWwubWFrZSBsb2NhbFJ1bnRpbWUpXG4gICBUdXBsZTAgKDpUdXBsZTAgVXRpbHMpXVxuICAoZG9cbiAgICAoc2FuaXRpemUgbG9jYWxSdW50aW1lIDpOYXRpdmUgOlN0cmVhbXMpXG4gICAgKGlmIGxvY2FsUnVudGltZS5OYXRpdmUuU3RyZWFtcy52YWx1ZXNcbiAgICAgICAgbG9jYWxSdW50aW1lLk5hdGl2ZS5TdHJlYW1zLnZhbHVlc1xuICAgICAgICAoc2V0ISBsb2NhbFJ1bnRpbWUuTmF0aXZlLlN0cmVhbXMudmFsdWVzIHtcblxuICA6bG9nQnVmZmVyIChGMiAoZm4gW2VuY29kaW5nIGNodW5rXVxuICAgIChkb1xuICAgICAgKC5sb2cgY29uc29sZVxuICAgICAgICAoaWYgY2h1bmsgKC50b1N0cmluZyBjaHVuayBlbmNvZGluZykgY2h1bmspKVxuICAgICAgKC5zdWNjZWVkIFRhc2sgVHVwbGUwKSkpKVxuXG4gIDsgQ2xhc3M6IHN0cmVhbS5SZWFkYWJsZVxuXG4gIDpvbiAoRjUgKGZuIFtMZWZ0IFJpZ2h0IGV2ZW50TmFtZSBzdHJlYW0gZl1cbiAgICAoZG9cbiAgICAgICgub24gc3RyZWFtIGV2ZW50TmFtZSAoZm4gW2NodW5rXVxuICAgICAgICAoLnBlcmZvcm0gVGFzayAoZlxuICAgICAgICAgIChpZiAoPT0gKHR5cGVvZiBjaHVuaykgXCJzdHJpbmdcIilcbiAgICAgICAgICAgIChMZWZ0IGNodW5rKVxuICAgICAgICAgICAgKFJpZ2h0IGNodW5rKSkpKSkpXG4gICAgICAoLnN1Y2NlZWQgVGFzayBUdXBsZTApKSkpXG5cbiAgOyByZWFkYWJsZS5pc1BhdXNlZCgpXG4gIDppc1BhdXNlZCAob28uZ2V0MCBcImlzUGF1c2VkXCIgVGFzaylcblxuICA7IHJlYWRhYmxlLnBhdXNlKClcbiAgOnBhdXNlIChvby5tZXRob2QwIFwicGF1c2VcIiBUYXNrIFR1cGxlMClcblxuICA7IHJlYWRhYmxlLnBpcGUoZGVzdGluYXRpb25bLCBvcHRpb25zXSlcbiAgOnBpcGUgKEYyIChvby5tZXRob2QyIFwicGlwZVwiIFRhc2sgVHVwbGUwKSlcblxuICA7IHJlYWRhYmxlLnJlYWQoW3NpemVdKVxuICA6cmVhZCAoRjUgKGZuIFtMZWZ0IFJpZ2h0IEp1c3QgTm90aGluZyBzdHJlYW1dXG4gICAgKC5zdWNjZWVkIFRhc2sgKGxldCBbeCAoLnJlYWQgc3RyZWFtKV1cbiAgICAgIChpZiB4XG4gICAgICAgIChKdXN0IChpZiAoPT0gXCJzdHJpbmdcIiAodHlwZW9mIHgpKVxuICAgICAgICAgIChMZWZ0ICB4KVxuICAgICAgICAgIChSaWdodCB4KSkpXG4gICAgICAgIE5vdGhpbmcpKSkpKVxuICA6cmVhZFNpemUgKEY2IChmbiBbTGVmdCBSaWdodCBKdXN0IE5vdGhpbmcgc3RyZWFtIHNpemVdXG4gICAgKC5zdWNjZWVkIFRhc2sgKGxldCBbeCAoLnJlYWQgc3RyZWFtIHNpemUpXVxuICAgICAgKGlmIHhcbiAgICAgICAgKEp1c3QgKGlmICg9PSBcInN0cmluZ1wiICh0eXBlb2YgeCkpXG4gICAgICAgICAgKExlZnQgIHgpXG4gICAgICAgICAgKFJpZ2h0IHgpKSlcbiAgICAgICAgTm90aGluZykpKSkpXG5cbiAgOyByZWFkYWJsZS5yZXN1bWUoKVxuICA6cmVzdW1lIChvby5tZXRob2QwIFwicmVzdW1lXCIgVGFzayBUdXBsZTApXG5cbiAgOyByZWFkYWJsZS5zZXRFbmNvZGluZyhlbmNvZGluZylcbiAgOnNldEVuY29kaW5nIChGMiAob28ubWV0aG9kMSBcInNldEVuY29kaW5nXCIgVGFzayBUdXBsZTApKVxuXG4gIDsgcmVhZGFibGUudW5waXBlKFtkZXN0aW5hdGlvbl0pXG4gIDp1bnBpcGUgKEYyIChvby5tZXRob2QxIFwidW5waXBlXCIgVGFzayBUdXBsZTApKVxuICA6dW5waXBlQWxsIChvby5tZXRob2QwIFwidW5waXBlXCIgVGFzayBUdXBsZTApXG5cbiAgOyByZWFkYWJsZS51bnNoaWZ0KGNodW5rKVxuICA6dW5zaGlmdCAoRjIgKG9vLm1ldGhvZDEgXCJ1bnNoaWZ0XCIgVGFzayBUdXBsZTApKVxuXG4gIDsgQ2xhc3M6IHN0cmVhbS5Xcml0YWJsZVxuXG4gIDsgd3JpdGFibGUuY29yaygpXG4gIDpjb3JrIChvby5tZXRob2QwIFwiY29ya1wiIFRhc2sgVHVwbGUwKVxuXG4gIDsgd3JpdGFibGUuZW5kKFtjaHVua11bLCBlbmNvZGluZ11bLCBjYWxsYmFja10pXG4gIDplbmRTdHJpbmcgKEYzIChvby5tZXRob2QyY2IgXCJlbmRcIiBUYXNrIFR1cGxlMCkpXG4gIDplbmRCdWZmZXIgKEYyIChvby5tZXRob2QxY2IgXCJlbmRcIiBUYXNrIFR1cGxlMCkpXG5cbiAgOyB3cml0YWJsZS5zZXREZWZhdWx0RW5jb2RpbmcoZW5jb2RpbmcpXG4gIDpzZXREZWZhdWx0RW5jb2RpbmcgKEYyIChvby5tZXRob2QxIFwic2V0RGVmYXVsdEVuY29kaW5nXCIgVGFzayBUdXBsZTApKVxuXG4gIDsgd3JpdGFibGUudW5jb3JrKClcbiAgOnVuY29yayAob28ubWV0aG9kMCBcInVuY29ya1wiIFRhc2sgVHVwbGUwKVxuXG4gIDsgd3JpdGFibGUud3JpdGUoY2h1bmtbLCBlbmNvZGluZ11bLCBjYWxsYmFja10pXG4gIDp3cml0ZVN0cmluZyAoRjIgKG9vLm1ldGhvZDFjYiBcIndyaXRlXCIgVGFzayBUdXBsZTApKVxuICA6d3JpdGVCdWZmZXIgKEYzIChvby5tZXRob2QyY2IgXCJ3cml0ZVwiIFRhc2sgVHVwbGUwKSlcblxuICA6d3JpdGVTdHJpbmdTaWduYWwgKEYzIChmblxuICAgIFtlbmNvZGluZyBzaWduYWwgc3RyZWFtXVxuICAgIChkb1xuICAgICAgKC5vdXRwdXQgU2lnbmFsIFwid3JpdGUtc3RyZWFtLWJ1ZmZlclwiIChmbiBbY2h1bmtdXG4gICAgICAgIChpZiBjaHVuayAoLndyaXRlIHN0cmVhbSBjaHVuayBlbmNvZGluZykpKSBzaWduYWwpXG4gICAgICAoLnN1Y2NlZWQgVGFzayBUdXBsZTApKSkpXG5cbiAgOndyaXRlQnVmZmVyU2lnbmFsIChGMiAoZm5cbiAgICBbc2lnbmFsIHN0cmVhbV1cbiAgICAoZG9cbiAgICAgICgub3V0cHV0IFNpZ25hbCBcIndyaXRlLXN0cmVhbS1idWZmZXJcIiAoZm4gW2NodW5rXVxuICAgICAgICAoaWYgY2h1bmsgKC53cml0ZSBzdHJlYW0gY2h1bmspKSkgc2lnbmFsKVxuICAgICAgKC5zdWNjZWVkIFRhc2sgVHVwbGUwKSkpKVxuXG59KSkpKSlcblxuKHNhbml0aXplIEVsbSA6TmF0aXZlIDpTdHJlYW1zKVxuKHNldCEgRWxtLk5hdGl2ZS5TdHJlYW1zLm1ha2UgbWFrZSlcbiJdfQ==
