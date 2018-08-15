From: Rob Herring <robh@kernel.org>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Wed, 15 Aug 2018 08:45:36 -0600
Message-ID: <CAL_JsqLwazj=7hOwSeAtcyvnYCmMDP-Nw3H8xHSr0n3YGUS21A@mail.gmail.com>
References: <20180812184152.GA22343@ravnborg.org>
 <f1f2a2d7-ae27-87af-8041-93d3f8fe07cc@microchip.com>
 <20180813181808.GA2357@ravnborg.org> <20180813220454.GA28913@rob-hp-laptop>
 <20180814164343.GA13848@ravnborg.org> <20180814224252.GA20667@rob-hp-laptop>
 <20180815044808.GA1806@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180815044808.GA1806@ravnborg.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sam Ravnborg <sam@ravnborg.org>, Peter Rosin <peda@axentia.se>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Linux PWM List <linux-pwm@vger.kernel.org>, Joshua Henderson <joshua.henderson@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel <dri-devel@lists.freedesktop.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Lee Jones <lee.jones@linaro.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

T24gVHVlLCBBdWcgMTQsIDIwMTggYXQgMTA6NDggUE0gU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJv
cmcub3JnPiB3cm90ZToKPgoKWy4uLl0KCj4gPiA+IE9uZSBEVCByZWxhdGVkIFE6Cj4gPiA+IFRo
ZSBMQ0QgQ29udHJvbGxlciBzdXBwb3J0cyBCR1I1NjUsIGJ1dCBhcyB0aGlzIGlzIGxlc3MgY29t
bW9uIHNvbWUgSFcgaW1wbG1lbnRhdGlvbnMKPiA+ID4gZXhjaGFuZ2UgUiBhbmQgQiwgZXhwZXNz
ZWQgaW4gdGhlIG9sZCBiaW5kaW5nIGFzIHdpcmluZy1tb2RlIGxpa2UgdGhpczoKPiA+ID4KPiA+
ID4gICAgIGF0bWVsLGxjZC13aXJpbmctbW9kZTogbGNkIHdpcmluZyBtb2RlICJSR0IiIG9yICJC
UkciCj4gPiA+Cj4gPiA+IEhvdyBjYW4gd2UgZXhwcmVzcyB0aGlzIHdpcmluZy1tb2RlIGluIGEg
Z2VuZXJpYyB3YXksIGJvdGggaW4gRFQgYW5kIGluIGNvZGU/Cj4gPiA+IElzIGl0IHNvbWV0aGlu
ZyB0aGF0IGluIERSTSBiZWxvbmdzIHRvIHRoZSBwYW5lbCwgdGhlIGVuY29kZXIsIHRoZSBjb25u
ZWN0b3IsIG9yPwo+ID4gPiBBbmQgY2FuIGFueSBvZiB0aGUgZXhpc2l0bmcgZmxhZ3MgYmUgdXNl
ZD8KPiA+Cj4gPiBJIHRob3VnaHQgd2UgaGFkIGNvbWUgdXAgd2l0aCBhIGNvbW1vbiBkZWZpbml0
aW9uLCBidXQgSSBndWVzcyBpdCBkaWRuJ3QKPiA+IG1ha2UgaXQgdXBzdHJlYW0uIEl0J3MgZGVm
aW5pdGVseSBuZWVkZWQgYW5kIEkndmUgYmVlbiByZWplY3RpbmcKPiA+IGFueXRoaW5nIG5ldyB0
aGF0J3MgdmVuZG9yIHNwZWNpZmljLgo+IEkgZm91bmQgdGhpczogaHR0cHM6Ly9wYXRjaHdvcmsu
b3psYWJzLm9yZy9wYXRjaC82NTk1NzAvCj4gVGhlIHN1Z2dlc3Rpb24gd2l0aCBhIGJvb2xlYW4g
c2VlbXMgc2ltcGxlIGFuZCBJIHdpbGwgdHJ5IHRoYXQuCgpUaGF0J3MgcmVhbGx5IHRvbyBzaW1w
bGUgdG8gYmUgY29tbW9uLiBUaGVyZSdzIGJlZW4gYSBmZXcgb3RoZXIKYXR0ZW1wdHNbMV1bMl1b
M10gKGZvciBBdG1lbCBITENEQyBpbiBmYWN0KSB3aXRoIFszXSBwcm9iYWJseSBiZWluZwp0aGUg
Y2xvc2VzdCB0byBtZXJnaW5nLiBUaGUgYmluZGluZyBsb29rZWQgZmluZSB0byBtZSwgYnV0IGxv
b2tzIGxpa2UKdGhlIERSTSBpbXBsZW1lbnRhdGlvbiBoYWQgc29tZSBpc3N1ZXMuCgpSb2IKClsx
XSBodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9hcmNoaXZlcy9kcmktZGV2ZWwvMjAxOC1B
cHJpbC8xNzMwODkuaHRtbApbMl0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC85
OTY1MDc5LwpbM10gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LWFy
bS1rZXJuZWwvMjAxOC1NYXJjaC81Njg3MzEuaHRtbApfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1h
bi9saXN0aW5mby9kcmktZGV2ZWwK
