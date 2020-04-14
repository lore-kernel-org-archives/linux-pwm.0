From: Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 10/16] gpio: add a reusable generic gpio_chip using
 regmap
Date: Tue, 14 Apr 2020 21:57:15 +0200
Message-ID: <eab972adf53bbac20b5a9e613fcfb5b0@walle.cc>
References: <20200402203656.27047-1-michael@walle.cc>
 <20200402203656.27047-11-michael@walle.cc>
 <CAMpxmJVE3PgVCxkQ-ryc5=KSrKcpdmk1cnJUxJBz9QFCx-e_+A@mail.gmail.com>
 <80bd8661ec8a1f5eda3f09a267846eaa@walle.cc>
 <CAMpxmJVC7e9JnHzBo-h8M1+KmcA32=Rvxo7+znH=-kAbcCr_LQ@mail.gmail.com>
 <e0388a2137e23d76b2415a7549c01dd1@walle.cc>
 <CAMpxmJW1x4Orh1BZ4TUoCsYeaAAZ4NBUNvoMG9JgP0iLvXTOtg@mail.gmail.com>
 <62d157198a75a59ada15c496deeab49b@walle.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <62d157198a75a59ada15c496deeab49b@walle.cc>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: linux-devicetree <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <maz@kernel.org>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Guenter Roeck <linux@roeck-us.net>, linux-pwm@vger.kernel.org, Jean Delvare <jdelvare@suse.com>, LINUXWATCHDOG <linux-watchdog@vger.kernel.org>, linux-gpio <linux-gpio@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Wim Van Sebroeck <wim@linux-watchdog.org>, arm-soc <linux-arm-kernel@lists.infradead.org>, linux-hwmon@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>
List-Id: linux-pwm@vger.kernel.org

SGkgTWFyaywgSGkgQmFydG9zeiwgSGkgTGludXMsCgpBbSAyMDIwLTA0LTE0IDIwOjQxLCBzY2hy
aWViIE1pY2hhZWwgV2FsbGU6Cj4gQW0gMjAyMC0wNC0xNCAxOTowMCwgc2NocmllYiBCYXJ0b3N6
IEdvbGFzemV3c2tpOgo+PiB3dC4sIDE0IGt3aSAyMDIwIG8gMTI6MDcgTWljaGFlbCBXYWxsZSA8
bWljaGFlbEB3YWxsZS5jYz4gbmFwaXNhxYIoYSk6Cj4+PiA+Pgo+Pj4gPj4gU28gdGhlIGJlc3Qg
ZnJvbSBhIHVzZXIgcGVyc3BlY3RpdmUgSSd2ZSBjb3VsZCBjb21lIHVwIHdpdGggd2FzOgo+Pj4g
Pj4KPj4+ID4+ICAgIC0+YmFzZV9yZWcgPSBHUElPX1JFR01BUF9BRERSKGFkZHIpOwo+Pj4gPj4K
Pj4+ID4+IEknbSBvcGVuIGZvciBzdWdnZXN0aW9ucy4KPj4+ID4+Cj4+PiA+Cj4+PiA+IE1heWJl
IHNldHRpbmcgdGhlIHBvaW50ZXIgdG8gRVJSX1BUUigtRU5PRU5UKSB3aGljaCB3aWxsIHJlc3Vs
dCBpbgo+Pj4gPiBJU19FUlIoKSByZXR1cm5pbmcgdHJ1ZT8KPj4+IAo+Pj4gVW5mb3J0dW5hdGx5
LCBpdHMgbm90IGEgcG9pbnRlciwgYnV0IG9ubHkgYSByZWd1bGFyIHVuc2lnbmVkIGludCAoaWUK
Pj4+IHRoZSB0eXBlIHRoZSByZWdtYXAgQVBJIGhhcyBmb3IgaXRzICJyZWciIHByb3BlcnR5KS4g
SXQgY291bGQgYmUgYQo+Pj4gcG9pbnRlciBvZiBjb3Vyc2UgYnV0IHRoZW4gdGhlIHVzZXIgd291
bGQgaGF2ZSB0byBhbGxvY2F0ZSBhZGRpdGlvbmFsCj4+PiBtZW1vcnkuCj4+PiAKPj4+IC1taWNo
YWVsCj4+PiAKPj4gCj4+IEVlaywgb2YgY291cnNlIGl0J3Mgbm90IGEgcG9pbnRlci4gSWYgcG9z
c2libGUgSSdkIGxpa2UgdG8gYXZvaWQgdGhpcwo+PiBHUElPX1JFR01BUF9BRERSKCkgbWFjcm8s
IHNvIGhvdyBhYm91dCBoYXZpbmcgc29tZSBzZXBhcmF0ZSBmaWVsZCBmb3IKPj4gaW52YWxpZCBv
ZmZzZXRzIG1ha2luZyBldmVyeSBvZmZzZXQgJ3ZhbGlkJyBieSBkZWZhdWx0Pwo+IAo+IElNSE8g
dGhpcyBoYXMgdGhlIHNhbWUgcHJvYmxlbXMgYXMgbWVudGlvbmVkIGluIHRoZSByZXNwb25zZSB0
byBNYXJrJ3MKPiBpZGVhLiBOb3JtYWxseSwgdGhlIHVzZXIgc2V0cyBvbmx5IHNvbWUgYWRkcmVz
c2VzLCB0aHVzIGhlIGhhcyB0byBtYXJrCj4gYWxsIG90aGVyIGFzIGludmFsaWQuIEFuZCBpZiB5
b3UgYWRkIGFub3RoZXIgYWRkcmVzcywgeW91IGhhdmUgdG8gdG91Y2gKPiBhbGwgdGhlIGRyaXZl
cnMgdG8gbWFyayBpdCBhcyBpbnZhbGlkLgo+IAo+IFdlIGNvdWxkIGFkZCBzb21lIGZvcmNlIGJp
dHMgbGlrZSB0aGUgInVzZV9hY2siIGZsYWcgaW4gdGhlIGJncGlvIAo+IGRyaXZlciwKPiB3aGVy
ZSB5b3UgY2FuIGZvcmNlIHRoZSB1c2Ugb2YgdGhlIHZhbHVlIDAuIEJ1dCBJJ2QgcmVhbGx5IGxp
a2UgdG8gZmluZAo+IGEgYmV0dGVyIHdheS4uCgpTbyB3aGF0IGFib3V0IHRoZSBmb2xsb3dpbmc6
CgojZGVmaW5lIEdQSU9fUkVHTUFQX0FERFJfWkVSTyAodW5zaWduZWQgaW50KSgtMSkKClNvIHRo
aXMgd2F5IHRoZSB1c2VyIG1pZ2h0IGFzc2lnbiB0aGUgYmFzZSBhZGRyZXNzZXMgdGhlIG5vcm1h
bCB3YXkKZXhjZXB0IHdoZW4gaGUgd2FudHMgdG8gdXNlIHplcm8sIGluIHRoYXQgY2FzZSBoZSBo
YXMgdG8gdXNlCgogICAtPmJhc2VfYWRyID0gR1BJT19SRUdNQVBfQUREUl9aRVJPOwoKZ3Bpby1y
ZWdtYXAuYyBjb3VsZCB1c2UgdGhlbjoKCmlmIChiYXNlX2FkZHIpCiAgIHNvbWV0aGluZ191c2Vm
dWwoZ3Bpb19yZWdtYXBfYWRkcihiYXNlX2FkZHIpKTsKCnVuc2lnbmVkIGludCBncGlvX3JlZ21h
cF9hZGRyKHVuc2lnbmVkIGludCBhZGRyKQp7CiAgIHJldHVybiAoYWRkciA9PSBHUElPX1JFR01B
UF9BRERSX1pFUk8pID8gMCA6IGFkZHI7Cn0KCi1taWNoYWVsCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlz
dApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJh
ZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
