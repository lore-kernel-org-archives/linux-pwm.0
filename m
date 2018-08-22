From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/7] atmel-hlcdc: renamed directory to drm/atmel/
Date: Wed, 22 Aug 2018 22:22:04 +0200
Message-ID: <CAKMK7uE34rkpFhZu6J9BRpTej4y8icYFopsXsozgsQcpj9h7vA@mail.gmail.com>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-1-sam@ravnborg.org>
 <20180814083913.GD21634@phenom.ffwll.local>
 <20180814161952.GA27951@ravnborg.org>
 <20180816074123.GB21634@phenom.ffwll.local>
 <20180822200942.GA22148@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20180822200942.GA22148@ravnborg.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm <linux-pwm@vger.kernel.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel <dri-devel@lists.freedesktop.org>, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pwm@vger.kernel.org

T24gV2VkLCBBdWcgMjIsIDIwMTggYXQgMTA6MDkgUE0sIFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5i
b3JnLm9yZz4gd3JvdGU6Cj4gSGkgRGFuaWVsLgo+Cj4+ID4gPgo+PiA+ID4gSSdkIHN0cm9uZ2x5
IHN1Z2dlc3QgeW91IGdyb3VwLW1haW50YWluIHRoZSBlbnRpcmUgYXRtZWwgc3R1ZmYgaW4KPj4g
PiA+IGRybS1taXNjIGluc3RlYWQgb2Ygb25seSBhdG1lbC1obGNkYy4KPj4gPgo+PiA+IElmIE9L
IHdpdGggQm9yaXMgdGhlbiBJIGFtIGZpbmUgd2l0aCB0aGlzIHRvby4KPj4gPiBXaWxsIHN1Z2dl
c3Qgc28gaW4gdjIuCj4+Cj4+IEJvcmlzIGFja2VkIHRvbywgYnV0IGhlJ3Mgb24gdmFjYXRpb24u
IEhlIHNhaWQgb24gaXJjIGhlJ2xsIHJldmlldyB0aGUKPj4gcGF0Y2hlcyB3aGVuIGhlJ3MgYmFj
ay4gTWVhbndoaWxlIEkgZ3Vlc3MgeW91IGNhbiBwcmVwIGJ5IGdldHRpbmcgdGhlIGZkLm8KPj4g
YWNjb3VudCByZXF1ZXN0ZWQ6Cj4+Cj4+IGh0dHBzOi8vd3d3LmZyZWVkZXNrdG9wLm9yZy93aWtp
L0FjY291bnRSZXF1ZXN0cy8KPj4KPj4gQW5kIGNoZWNraW5nIG91dCB0aGUgdG9vbGluZyB3ZSB1
c2UgdG8gbWFpbnRhaW4gZHJtLW1pc2M6Cj4+Cj4+IGh0dHBzOi8vZHJpLmZyZWVkZXNrdG9wLm9y
Zy9kb2NzL2RpbS9nZXR0aW5nLXN0YXJ0ZWQuaHRtbAo+Cj4gV2l0aCBlbm91Z2ggb24gdGhlIHBs
YXRlIGFscmVhZHkgSSBkZWNpZGVkIHRvIHBvc3Rwb25lIHRoaXMKPiBwYXJ0IHVudGlsIHRoZSBt
aWdyYXRpb24gdG8gZ2l0bGFiIGlzIGRvbmUuCj4gSnVzdCB0byB0ZWxsIHRoaXMgd2FzIG5vdCBp
Z25vcmVkLCBvbmx5IHBvc3Rwb25lZC4KCk1pZ3JhdGluZyB0aGUgZHJtIHJlcG9zIHdpbGwgc3Rh
cnQgZWFybGllc3QgbmV4dCB5ZWFyIChiZWNhdXNlIGZkLm8KYWRtaW5zIG5lZWQgdG8gcmV3b3Jr
IHNvbWUgb2YgdGhlIGluZnJhc3RydWN0dXJlKS4gQW5kIHRoaXMgaXMgdGhlCm9wdGltaXN0aWMg
ZXN0aW1hdGUuIFdlJ2xsIGFsc28gdHJ5IHRvIG1ha2UgdGhlIHRyYW5zaXRpb24gYXMgc2VhbWxl
c3MKYXMgcG9zc2libGUgZm9yIGNvbW1pdHRlcnMgKHRoZSBzY3JpcHRpbmcgd2UncmUgdXNpbmcg
d2lsbAphdXRvLXVwZ3JhZGUgcmVtb3RlcyBhbmQgZXZlcnl0aGluZywgcGx1cyBhY2NvdW50cyB3
aWxsIGdldCBtaWdyYXRlZCkuCgpIb2xkaW5nIG9mZiBpbW8gZG9lc24ndCBtYWtlIHNlbnNlLCBq
dXN0IG1lYW5zIHlvdXIgZHJpdmVyIHdvbid0IGxhbmQKZm9yIGFub3RoZXIgNiBtb250aHMgb3Ig
c28sIG9yIGF0IGxlYXN0IGJlIGluIHNvbWUgZnVubnkgbWFpbnRhaW5lcgpsaW1ibyBzdGF0ZS4K
LURhbmllbAotLSAKRGFuaWVsIFZldHRlcgpTb2Z0d2FyZSBFbmdpbmVlciwgSW50ZWwgQ29ycG9y
YXRpb24KKzQxICgwKSA3OSAzNjUgNTcgNDggLSBodHRwOi8vYmxvZy5mZndsbC5jaApfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGlu
ZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVl
ZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
