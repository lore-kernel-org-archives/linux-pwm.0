From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Thu, 23 Aug 2018 08:16:47 +0200
Message-ID: <CAKMK7uFC-gmJQqJnDBNYJi0KXQ2=z9ukz2E+eQuSC2W+3QXRTw@mail.gmail.com>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812195536.GA29811@ravnborg.org>
 <264d51a0-7e41-6c27-d438-9ae337e6dcf0@microchip.com>
 <20180814084112.GE21634@phenom.ffwll.local>
 <20180822201226.GB22148@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180822201226.GB22148@ravnborg.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm <linux-pwm@vger.kernel.org>, Joshua Henderson <joshua.henderson@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel <dri-devel@lists.freedesktop.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCBBdWcgMjIsIDIwMTggYXQgMTA6MTIgUE0sIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5i
b3JnLm9yZz4gd3JvdGU6Cj4gSGkgRGFuaWVsLgo+Cj4+ID4gPiBCYXNlZCBvbiB0aGUgYWJvdmUs
IHdvdWxkIGl0IGJlIHBvc3NpYmxlIHRvIHV0aWxpc2Ugc29tZQo+PiA+ID4gb2YgdGhlc2UgZmVh
dHVyZXMgd2l0aG91dCBhbnkgZGVkaWNhdGVkIHVzZXJzcGFjZSAobWVzYSkgc3VwcG9ydD8KPj4g
PiA+IEFueSBvdGhlciBkcml2ZXIgdGhhdCBoYXMgc29tZXRoaW5nIHNpbWlsYXIgdGhhdCBjYW4g
YmUgdXNlZAo+PiA+ID4gZm9yIGluc3BpcmF0aW9uPwo+PiA+Cj4+ID4gVGhpcyBpcyByZWFsbHkg
YW4gaW50ZXJlc3RpbmcgcXVlc3Rpb24gaW5kZWVkLgo+Pgo+PiBOZWVkcyB1c2Vyc3BhY2UgbGlr
ZSBldmVyeXRoaW5nIGVsc2UuIFRoZXJlJ3MgdW5mb3J0dW5hdGVseSBubyByZWFsCj4+IHN0YW5k
YXJkIGZvciAyZCBhcGlzIGluIHVzZXJzcGFjZSwgd2hpY2ggbWVhbnMgbm9uZSBvZiB0aGVzZSBl
ZmZvcnRzIGdvCj4+IHZlcnkgZmFyLiBNb3N0bHkgaXQncyBqdXN0IHNvbWUgY3VzdG9tLW1hZGUg
WCBkcml2ZXJzLgo+Pgo+PiBBZGRpbmcgYSBnZW5lcmljIDJkIGFwaSB0byBkcm0gaXMgYSBGQVEs
IGFuZCB0aGUgYW5zd2VyIGlzICJubyIuCj4KPiBBbmQgdGhlbiB5b3Ugd2VudCBvZmYgd3JpdGlu
ZyBhIGJsb2cgcG9zdCBhYm91dCBpdCAtIHRoYW5rcy4KPiBUaGUgYmxvZyBwb3N0IHByb3ZpZGVk
IGEgbG90IG9mIHVzZWZ1bCBhbnN3ZXJzIC0gZ3JlYXQuCgpZZWFoIEkgZmlndXJlZCBtb3JlIGRl
dGFpbCB0aGFuIHRoaXMgaGVyZSB3b3VsZCBiZSBnb29kLCBidXQgYWxzbwp3YW50ZWQgdG8gYXZv
aWQgaGF2aW5nIHRvIHJldHlwZSB0aGF0IGV2ZXIgYWdhaW4uCgo+IChPciByYXRoZXIgeW91IHdp
bGwgd3JpdGUgdGhlIGJsb2cgaW4gNSBkYXlzLCBzZWVtcyB0byBiZSBzb21lIHRpbWUKPiAgbWFj
aGluZSBpbnZvbHZlZC4gKERhdGUgaXMgdGhlIDI3dGggYmVsb3cgdGhlIHRpdGxlKSkuCgpNeSBi
bG9nIHBsYXRmb3JtIHB1bGxlZCBvbmUgb24gbWUgLSBwdXNoZWQgaXQgb3V0IHdpdGggYSBmdXR1
cmUgZGF0ZSwKd2l0aCB0aGUgaWRlYSB0byBwcm9vZi1yZWFkIGEgYml0IG1vcmUuIERpZG4ndCB3
b3JrLCBzbyBldmVyeW9uZSByZWFkCnRoZSBzbGlnaHRseSBkcmFmdC1pc2ggdmVyc2lvbiA6LS8g
SW4gdGhlIHBhc3QgdGhpcyBkaWQgd29yaywgYW5kIHdhcwp2ZXJ5IG5lYXQuCi1EYW5pZWwKLS0g
CkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5lZXIsIEludGVsIENvcnBvcmF0aW9uCis0MSAo
MCkgNzkgMzY1IDU3IDQ4IC0gaHR0cDovL2Jsb2cuZmZ3bGwuY2gKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmkt
ZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3Jn
L21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
