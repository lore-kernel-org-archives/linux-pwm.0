From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH 3/3] pwm: bcm2835: suppress error message during deferred
 probe
Date: Sat, 24 Aug 2019 11:44:10 +0200
Message-ID: <141b0cb0-fa5c-ba3b-12cd-8e8252b1eb4e@gmx.net>
References: <1566630445-4599-1-git-send-email-wahrenst@gmx.net>
 <1566630445-4599-4-git-send-email-wahrenst@gmx.net>
 <20190824093032.cunkmukx73vl4hy3@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190824093032.cunkmukx73vl4hy3@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Scott Branden <sbranden@broadcom.com>, Ray Jui <rjui@broadcom.com>, Eric Anholt <eric@anholt.net>, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

QW0gMjQuMDguMTkgdW0gMTE6MzAgc2NocmllYiBVd2UgS2xlaW5lLUvDtm5pZzoKPiBPbiBTYXQs
IEF1ZyAyNCwgMjAxOSBhdCAwOTowNzoyNUFNICswMjAwLCBTdGVmYW4gV2FocmVuIHdyb3RlOgo+
PiBUaGlzIHN1cHByZXNzZXMgZXJyb3IgbWVzc2FnZXMgaW4gY2FzZSB0aGUgUFdNIGNsb2NrIGlz
bid0IHJlYWR5IHlldC4KPj4KPj4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFdhaHJlbiA8d2FocmVu
c3RAZ214Lm5ldD4KPj4gLS0tCj4+ICBkcml2ZXJzL3B3bS9wd20tYmNtMjgzNS5jIHwgNSArKysr
LQo+PiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pgo+
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWJjbTI4MzUuYyBiL2RyaXZlcnMvcHdtL3B3
bS1iY20yODM1LmMKPj4gaW5kZXggMmM4MjM4Ni4uY2UzNjJiZSAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy9wd20vcHdtLWJjbTI4MzUuYwo+PiArKysgYi9kcml2ZXJzL3B3bS9wd20tYmNtMjgzNS5j
Cj4+IEBAIC0xNTMsNyArMTUzLDEwIEBAIHN0YXRpYyBpbnQgYmNtMjgzNV9wd21fcHJvYmUoc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPj4KPj4gIAlwYy0+Y2xrID0gZGV2bV9jbGtfZ2V0
KCZwZGV2LT5kZXYsIE5VTEwpOwo+PiAgCWlmIChJU19FUlIocGMtPmNsaykpIHsKPj4gLQkJZGV2
X2VycigmcGRldi0+ZGV2LCAiY2xvY2sgbm90IGZvdW5kOiAlbGRcbiIsIFBUUl9FUlIocGMtPmNs
aykpOwo+PiArCQlpZiAoUFRSX0VSUihwYy0+Y2xrKSAhPSAtRVBST0JFX0RFRkVSKSB7Cj4+ICsJ
CQlkZXZfZXJyKCZwZGV2LT5kZXYsICJjbG9jayBub3QgZm91bmQ6ICVsZFxuIiwKPj4gKwkJCQlQ
VFJfRVJSKHBjLT5jbGspKTsKPj4gKwkJfQo+PiAgCQlyZXR1cm4gUFRSX0VSUihwYy0+Y2xrKTsK
Pj4gIAl9Cj4gSSB3b3VsZCBoYXZlIHVzZWQ6Cj4KPiAJaWYgKElTX0VSUihwYy0+Y2xrKSkgewo+
IAkJaW50IGVyciA9IFBUUl9FUlIocGMtPmNsayk7Cj4gCQlpZiAoZXJyICE9IC1FUFJPQkVfREVG
RVIpCj4gCQkJZGV2X2VycigmcGRldi0+ZGV2LCAiY2xvY2sgbm90IGZvdW5kOiAlZFxuIiwgZXJy
KTsKPgo+IAkJcmV0dXJuIGVycjsKPiAJfQo+Cj4gVGhpcyBjYWxjdWxhdGVzIHRoZSBlcnJvciBj
b2RlIG9ubHkgb25jZSBhbmQgbWFrZSB0aGUgZGV2X2VyciBsaW5lIHNob3J0Cj4gZW5vdWdoIHRv
IG5vdCBtYWtlIGl0IG5lY2Vzc2FyeSB0byBhZGQgYSBsaW5lIGJyZWFrLgpTdXJlIHRoYXQncyBi
ZXR0ZXIuIFdpbGwgc2VuZCBWMiBzb29uCj4KPiBCZXN0IHJlZ2FyZHMKPiBVd2UKPgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5l
bCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
