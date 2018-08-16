From: Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH v1 1/7] atmel-hlcdc: renamed directory to drm/atmel/
Date: Thu, 16 Aug 2018 09:41:23 +0200
Message-ID: <20180816074123.GB21634@phenom.ffwll.local>
References: <20180812184152.GA22343@ravnborg.org>
 <20180812184629.3808-1-sam@ravnborg.org>
 <20180814083913.GD21634@phenom.ffwll.local>
 <20180814161952.GA27951@ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180814161952.GA27951@ravnborg.org>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>, dri-devel@lists.freedesktop.org, Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

T24gVHVlLCBBdWcgMTQsIDIwMTggYXQgMDY6MTk6NTJQTSArMDIwMCwgU2FtIFJhdm5ib3JnIHdy
b3RlOgo+IEhpIERhbmllbC4KPiAKPiA+ID4gIHJlbmFtZSBkcml2ZXJzL2dwdS9kcm0ve2F0bWVs
LWhsY2RjID0+IGF0bWVsfS9hdG1lbF9obGNkY19wbGFuZS5jICgxMDAlKQo+ID4gPiAKPiA+ID4g
ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMKPiA+ID4gaW5kZXggOTZlOThl
MjA2YjBkLi4wOWNlNzZhOWExZGMgMTAwNjQ0Cj4gPiA+IC0tLSBhL01BSU5UQUlORVJTCj4gPiA+
ICsrKyBiL01BSU5UQUlORVJTCj4gPiA+IEBAIC00NjgxLDcgKzQ2ODEsNyBAQCBEUk0gRFJJVkVS
UyBGT1IgQVRNRUwgSExDREMKPiA+ID4gIE06CUJvcmlzIEJyZXppbGxvbiA8Ym9yaXMuYnJlemls
bG9uQGJvb3RsaW4uY29tPgo+ID4gPiAgTDoJZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
Zwo+ID4gPiAgUzoJU3VwcG9ydGVkCj4gPiA+IC1GOglkcml2ZXJzL2dwdS9kcm0vYXRtZWwtaGxj
ZGMvCj4gPiA+ICtGOglkcml2ZXJzL2dwdS9kcm0vYXRtZWwvYXRtZWwtaGxjZGMqCj4gPiAKPiA+
IEknZCBzdHJvbmdseSBzdWdnZXN0IHlvdSBncm91cC1tYWludGFpbiB0aGUgZW50aXJlIGF0bWVs
IHN0dWZmIGluCj4gPiBkcm0tbWlzYyBpbnN0ZWFkIG9mIG9ubHkgYXRtZWwtaGxjZGMuCj4gCj4g
SWYgT0sgd2l0aCBCb3JpcyB0aGVuIEkgYW0gZmluZSB3aXRoIHRoaXMgdG9vLgo+IFdpbGwgc3Vn
Z2VzdCBzbyBpbiB2Mi4KCkJvcmlzIGFja2VkIHRvbywgYnV0IGhlJ3Mgb24gdmFjYXRpb24uIEhl
IHNhaWQgb24gaXJjIGhlJ2xsIHJldmlldyB0aGUKcGF0Y2hlcyB3aGVuIGhlJ3MgYmFjay4gTWVh
bndoaWxlIEkgZ3Vlc3MgeW91IGNhbiBwcmVwIGJ5IGdldHRpbmcgdGhlIGZkLm8KYWNjb3VudCBy
ZXF1ZXN0ZWQ6CgpodHRwczovL3d3dy5mcmVlZGVza3RvcC5vcmcvd2lraS9BY2NvdW50UmVxdWVz
dHMvCgpBbmQgY2hlY2tpbmcgb3V0IHRoZSB0b29saW5nIHdlIHVzZSB0byBtYWludGFpbiBkcm0t
bWlzYzoKCmh0dHBzOi8vZHJpLmZyZWVkZXNrdG9wLm9yZy9kb2NzL2RpbS9nZXR0aW5nLXN0YXJ0
ZWQuaHRtbAoKQ2hlZXJzLCBEYW5pZWwKLS0gCkRhbmllbCBWZXR0ZXIKU29mdHdhcmUgRW5naW5l
ZXIsIEludGVsIENvcnBvcmF0aW9uCmh0dHA6Ly9ibG9nLmZmd2xsLmNoCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
