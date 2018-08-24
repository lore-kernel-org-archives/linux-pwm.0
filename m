From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH v1 3/7] mfd: add atmel-lcdc driver
Date: Fri, 24 Aug 2018 10:37:12 +0200
Message-ID: <20180824103712.1d889f17@bbrezillon>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-3-sam@ravnborg.org>
 <20180815052435.GA6412@dell> <20180815204041.GA29041@ravnborg.org>
 <1afc6d63-094b-3bff-87e9-d2354602ba76@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1afc6d63-094b-3bff-87e9-d2354602ba76@microchip.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>, Boris Brezillon <boris.brezillon@free-electrons.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gVGh1LCAxNiBBdWcgMjAxOCAxMDoyODo1NCArMDIwMApOaWNvbGFzIEZlcnJlIDxuaWNvbGFz
LmZlcnJlQG1pY3JvY2hpcC5jb20+IHdyb3RlOgoKPiBPbiAxNS8wOC8yMDE4IGF0IDIyOjQwLCBT
YW0gUmF2bmJvcmcgd3JvdGU6Cj4gPiBIaSBMZWUuCj4gPiAgIAo+ID4+PiArCj4gPj4+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IG1mZF9jZWxsIGxjZGNfY2VsbHNbXSA9IHsKPiA+Pj4gKwl7Cj4gPj4+
ICsJCS5uYW1lID0gImF0bWVsLWxjZGMtcHdtIiwKPiA+Pj4gKwkJLm9mX2NvbXBhdGlibGUgPSAi
YXRtZWwsbGNkYy1wd20iLAo+ID4+PiArCX0sCj4gPj4+ICsJewo+ID4+PiArCQkubmFtZSA9ICJh
dG1lbC1sY2RjLWRjIiwKPiA+Pj4gKwkJLm9mX2NvbXBhdGlibGUgPSAiYXRtZWwsbGNkYy1kaXNw
bGF5LWNvbnRyb2xsZXIiLAo+ID4+PiArCX0sCj4gPj4+ICt9OyAgCj4gPj4KPiA+PiBXaWxsIHlv
dSBiZSBhZGRpbmcgYW55IG1vcmUgZGV2aWNlcywgb3IgaXMgdGhpcyB0aGUgZW50aXJldHkgb2Yg
dGhlCj4gPj4gZGV2aWNlPyAgSWYgdGhlIGxhdHRlciwgSSBzdWdnZXN0IHRoYXQgdGhpcyBkb2Vz
bid0IHdhcnJhbnQgYmVpbmcgYW4KPiA+PiBNRkQuICAKPiA+IFRoYXRzIGl0LiBBbmQgb3RoZXJz
IGFncmVlIHdpdGggeW91IHRoYXQgdGhpcyBpcyBub3QgYSBnb29kIGFwcHJvYWNoLgo+ID4gU28g
aW4gdjIgdGhlcmUgd2lsbCBiZSBubyBNRkQuCj4gPiAKPiA+IFRoYW5rcyBmb3IgY29uZmlybWlu
ZyB0aGF0IHRoZSBub24tbWZkIHdheSBpcyB0aGUgYmV0dGVyIGFwcHJvYWNoLiAgCj4gCj4gTUZE
IGFwcHJvYWNoIHdvdWxkIGhhdmUgaGFkIHRoZSBiZW5lZml0IG9mIGtlZXBpbmcgdGhpcyBkcml2
ZXIgc2VyaWVzIAo+IGFyY2hpdGVjdHVyZSBjbG9zZSB0byB0aGUgSExDRCBvbmUuIFRoaXMgd291
bGQgaGF2ZSBiZWVuIGVhc2llciB0byAKPiB1bmRlcnN0YW5kIGFuZCB1c2Ugb25lIFNvQyBvciBh
bm90aGVyIG9uZSBmcm9tIHRoZSBBVDkxIHByb2R1Y3QgbGluZS4uLi4KPiAKPiBBbnl3YXksIEkn
ZCB3YWl0IGZvciBCb3JpcycgZmVlZGJhY2sgZm9yIG1ha2luZyBhIGRlY2lzaW9uLgoKSWYgcG9z
c2libGUgSSdkIGxpa2UgdG8ga2VlcCB0aGUgTUZEIGFwcHJvYWNoLCBidXQgbGV0J3Mgc2VlIGlm
IHdlIGNhbgpoYXZlIGEgc2luZ2xlIG5vZGUgaW4gdGhlIERUIGluc3RlYWQgb2Ygb25lIGZvciB0
aGUgTUZEIGFuZCAyIGNoaWxkCm5vZGVzIChmb3IgdGhlIGRpc3BsYXkgY29udHJvbGxlciBhbmQg
dGhlIFBXTSkuCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
CmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpo
dHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
