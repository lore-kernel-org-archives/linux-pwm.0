From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC PATCH 0/7] add at91sam9 LCDC DRM driver
Date: Wed, 22 Aug 2018 22:12:26 +0200
Message-ID: <20180822201226.GB22148@ravnborg.org>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812195536.GA29811@ravnborg.org>
 <264d51a0-7e41-6c27-d438-9ae337e6dcf0@microchip.com>
 <20180814084112.GE21634@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180814084112.GE21634@phenom.ffwll.local>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Daniel Vetter <daniel@ffwll.ch>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Joshua Henderson <joshua.henderson@microchip.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

SGkgRGFuaWVsLgoKPiA+ID4gQmFzZWQgb24gdGhlIGFib3ZlLCB3b3VsZCBpdCBiZSBwb3NzaWJs
ZSB0byB1dGlsaXNlIHNvbWUKPiA+ID4gb2YgdGhlc2UgZmVhdHVyZXMgd2l0aG91dCBhbnkgZGVk
aWNhdGVkIHVzZXJzcGFjZSAobWVzYSkgc3VwcG9ydD8KPiA+ID4gQW55IG90aGVyIGRyaXZlciB0
aGF0IGhhcyBzb21ldGhpbmcgc2ltaWxhciB0aGF0IGNhbiBiZSB1c2VkCj4gPiA+IGZvciBpbnNw
aXJhdGlvbj8KPiA+IAo+ID4gVGhpcyBpcyByZWFsbHkgYW4gaW50ZXJlc3RpbmcgcXVlc3Rpb24g
aW5kZWVkLgo+IAo+IE5lZWRzIHVzZXJzcGFjZSBsaWtlIGV2ZXJ5dGhpbmcgZWxzZS4gVGhlcmUn
cyB1bmZvcnR1bmF0ZWx5IG5vIHJlYWwKPiBzdGFuZGFyZCBmb3IgMmQgYXBpcyBpbiB1c2Vyc3Bh
Y2UsIHdoaWNoIG1lYW5zIG5vbmUgb2YgdGhlc2UgZWZmb3J0cyBnbwo+IHZlcnkgZmFyLiBNb3N0
bHkgaXQncyBqdXN0IHNvbWUgY3VzdG9tLW1hZGUgWCBkcml2ZXJzLgo+IAo+IEFkZGluZyBhIGdl
bmVyaWMgMmQgYXBpIHRvIGRybSBpcyBhIEZBUSwgYW5kIHRoZSBhbnN3ZXIgaXMgIm5vIi4KCkFu
ZCB0aGVuIHlvdSB3ZW50IG9mZiB3cml0aW5nIGEgYmxvZyBwb3N0IGFib3V0IGl0IC0gdGhhbmtz
LgpUaGUgYmxvZyBwb3N0IHByb3ZpZGVkIGEgbG90IG9mIHVzZWZ1bCBhbnN3ZXJzIC0gZ3JlYXQu
CgooT3IgcmF0aGVyIHlvdSB3aWxsIHdyaXRlIHRoZSBibG9nIGluIDUgZGF5cywgc2VlbXMgdG8g
YmUgc29tZSB0aW1lCiBtYWNoaW5lIGludm9sdmVkLiAoRGF0ZSBpcyB0aGUgMjd0aCBiZWxvdyB0
aGUgdGl0bGUpKS4KCglTYW0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0
b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJp
LWRldmVsCg==
