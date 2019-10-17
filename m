From: Daniel Thompson <daniel.thompson@linaro.org>
Subject: Re: [PATCH] backlight: pwm_bl: configure pwm only once per backlight
 toggle
Date: Thu, 17 Oct 2019 14:18:02 +0100
Message-ID: <20191017131802.defwuzrgq4ai4mud@holly.lan>
References: <20191017081059.31761-1-u.kleine-koenig@pengutronix.de>
 <20191017114727.fy5tg2kgi6mr2sei@holly.lan>
 <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20191017121945.cmcvaffmbd7zydrm@pengutronix.de>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, Adam Ford <aford173@gmail.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, kernel@pengutronix.de, Jingoo Han <jingoohan1@gmail.com>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, Lee Jones <lee.jones@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gVGh1LCBPY3QgMTcsIDIwMTkgYXQgMDI6MTk6NDVQTSArMDIwMCwgVXdlIEtsZWluZS1Lw7Zu
aWcgd3JvdGU6Cj4gT24gVGh1LCBPY3QgMTcsIDIwMTkgYXQgMTI6NDc6MjdQTSArMDEwMCwgRGFu
aWVsIFRob21wc29uIHdyb3RlOgo+ID4gT24gVGh1LCBPY3QgMTcsIDIwMTkgYXQgMTA6MTA6NTlB
TSArMDIwMCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6Cj4gPiA+IEEgcHJldmlvdXMgY2hhbmdl
IGluIHRoZSBwd20gY29yZSAobmFtZWx5IDAxY2NmOTAzZWRkNiAoInB3bTogTGV0Cj4gPiA+IHB3
bV9nZXRfc3RhdGUoKSByZXR1cm4gdGhlIGxhc3QgaW1wbGVtZW50ZWQgc3RhdGUiKSkgY2hhbmdl
ZCB0aGUKPiA+ID4gc2VtYW50aWMgb2YgcHdtX2dldF9zdGF0ZSgpIGFuZCBkaXNjbG9zZWQgYW4g
KGFzIGl0IHNlZW1zKSBjb21tb24KPiA+ID4gcHJvYmxlbSBpbiBsb3dsZXZlbCBQV00gZHJpdmVy
cy4gQnkgbm90IHJlbHlpbmcgb24gdGhlIHBlcmlvZCBhbmQgZHV0eQo+ID4gPiBjeWNsZSBiZWlu
ZyByZXRyaWV2YWJsZSBmcm9tIGEgZGlzYWJsZWQgUFdNIHRoaXMgdHlwZSBvZiBwcm9ibGVtIGlz
Cj4gPiA+IHdvcmtlZCBhcm91bmQuCj4gPiA+IAo+ID4gPiBBcGFydCBmcm9tIHRoaXMgaXNzdWUg
b25seSBjYWxsaW5nIHRoZSBwd21fZ2V0X3N0YXRlL3B3bV9hcHBseV9zdGF0ZQo+ID4gPiBjb21i
byBvbmNlIGlzIGFsc28gbW9yZSBlZmZlY3RpdmUuCj4gPiAKPiA+IEknbSBvbmx5IGludGVyZXN0
ZWQgaW4gdGhlIHNlY29uZCBwYXJhZ3JhcGggaGVyZS4KPiA+IAo+ID4gVGhlcmUgc2VlbXMgdG8g
YmUgYSByZWFzb25hYmxlIGNvbnNlbnN1cyB0aGF0IHRoZSBpLk1YMjcgYW5kIGNyb3MtZWMKPiA+
IFBXTSBkcml2ZXJzIHNob3VsZCBiZSBmaXhlZCBmb3IgdGhlIGJlbmVmaXQgb2Ygb3RoZXIgUFdN
IGNsaWVudHMuCj4gPiBTbyB3ZSBtYWtlIHRoaXMgY2hhbmdlIGJlY2F1c2UgaXQgbWFrZXMgdGhl
IHB3bS1ibCBiZXR0ZXIuLi4gbm90IHRvCj4gPiB3b3JrIGFyb3VuZCBidWdzIDstKS4KPiAKPiBU
aGF0J3MgZmluZSwgc3RpbGwgSSB0aGluayBpdCdzIGZhaXIgdG8gZXhwbGFpbiB0aGUgbW90aXZh
dGlvbiBvZgo+IGNyZWF0aW5nIHRoaXMgcGF0Y2guCgpNYXliZS4KCldoZXRoZXIgdGhpcyBwYXRj
aCBpcyBhIHdvcmthcm91bmQgb3Igc2ltcGx5IGFuIGltcHJvdmVtZW50IHRvIHB3bS1ibApkb2Vz
IG5lZWQgdG8gYmUgY2xlYXIgc2luY2UgaXQgYWZmZWN0cyB3aGV0aGVyIExlZSBzdGVlcnMgaXQg
dG93YXJkcwp2NS40LXJjWCBvciBsaW51eC1uZXh0IC4KCgpEYW5pZWwuCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
