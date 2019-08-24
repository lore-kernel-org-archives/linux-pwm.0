From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH v2 1/6] pwm: atmel: Add a hint where to find hardware
 documentation
Date: Sat, 24 Aug 2019 02:10:36 +0200
Message-ID: <20190824001041.11007-2-uwe@kleine-koenig.org>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190824001041.11007-1-uwe@kleine-koenig.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

TW9zdCBNaWNyb2NoaXAgKGZvcm1lcmx5IEF0bWVsKSBjaGlwcyBoYXZlIHB1YmxpY2x5IGF2YWls
YWJsZSBtYW51YWxzLgpBIGNvbXByZWhlbnNpdmUgbGlzdCBpcyBhbHJlYWR5IGNvbnRhaW5lZCBp
biB0aGUgZG9jdW1lbnRhdGlvbiBmb2xkZXIuClJlZmVyZW5jZSB0aGlzIGxpc3QgaW4gdGhlIGhl
YWRlciBvZiB0aGUgZHJpdmVyIHRvIGFsbG93IHJldmlld2VycyB0bwpmaW5kIHRoZSByZWxldmFu
dCBtYW51YWxzLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHV3ZUBrbGVpbmUt
a29lbmlnLm9yZz4KLS0tCkNoYW5nZXMgc2luY2UgKGltcGxpY2l0KSB2MSBzZW50IHdpdGggTWVz
c2FnZS1JZDoKMjAxOTA4MTUyMTQxMzMuMTExMzQtMS11d2VAa2xlaW5lLWtvZW5pZy5vcmc6Cgog
LSBPbmx5IHJlZmVyZW5jZSBEb2N1bWVudGF0aW9uL2FybS9taWNyb2NoaXAucnN0IGluc3RlYWQg
b2Ygc3RhcnRpbmcKICAgYW5vdGhlciBsaXN0IG9mIGxpbmtzCgogZHJpdmVycy9wd20vcHdtLWF0
bWVsLmMgfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMKaW5k
ZXggZTVlMWVhZjM3MmZhLi5hNjFhMzBmYThiN2UgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcHdtL3B3
bS1hdG1lbC5jCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jCkBAIC00LDYgKzQsOSBAQAog
ICoKICAqIENvcHlyaWdodCAoQykgMjAxMyBBdG1lbCBDb3Jwb3JhdGlvbgogICoJCSBCbyBTaGVu
IDx2b2ljZS5zaGVuQGF0bWVsLmNvbT4KKyAqCisgKiBMaW5rcyB0byByZWZlcmVuY2UgbWFudWFs
cyBmb3IgdGhlIHN1cHBvcnRlZCBQV00gY2hpcHMgY2FuIGJlIGZvdW5kIGluCisgKiBEb2N1bWVu
dGF0aW9uL2FybS9taWNyb2NoaXAucnN0LgogICovCiAKICNpbmNsdWRlIDxsaW51eC9jbGsuaD4K
LS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LWFybS1rZXJuZWwK
