From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH v2 5/6] pwm: atmel: use atmel_pwm_writel in
 atmel_pwm_ch_writel; ditto for readl
Date: Sat, 24 Aug 2019 02:10:40 +0200
Message-ID: <20190824001041.11007-6-uwe@kleine-koenig.org>
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

VGhpcyBtYWtlcyBpdCBhIGJpdCBlYXNpZXIgd2hlbiBpbnN0cnVtZW50aW5nIHJlZ2lzdGVyIGFj
Y2VzcyB0byBvbmx5IGhhdmUKdG8gYWRkIGNvZGUgaW4gb25lIHBsYWNlLgoKU2lnbmVkLW9mZi1i
eTogVXdlIEtsZWluZS1Lw7ZuaWcgPHV3ZUBrbGVpbmUta29lbmlnLm9yZz4KLS0tCk5ldyBpbiB2
MgoKIGRyaXZlcnMvcHdtL3B3bS1hdG1lbC5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3
bS1hdG1lbC5jIGIvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMKaW5kZXggODlmM2E2MmY3NTQxLi4x
NTJjMmI3ZGQ2ZGYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcHdtL3B3bS1hdG1lbC5jCisrKyBiL2Ry
aXZlcnMvcHdtL3B3bS1hdG1lbC5jCkBAIC0xMTEsNyArMTExLDcgQEAgc3RhdGljIGlubGluZSB1
MzIgYXRtZWxfcHdtX2NoX3JlYWRsKHN0cnVjdCBhdG1lbF9wd21fY2hpcCAqY2hpcCwKIHsKIAl1
bnNpZ25lZCBsb25nIGJhc2UgPSBQV01fQ0hfUkVHX09GRlNFVCArIGNoICogUFdNX0NIX1JFR19T
SVpFOwogCi0JcmV0dXJuIHJlYWRsX3JlbGF4ZWQoY2hpcC0+YmFzZSArIGJhc2UgKyBvZmZzZXQp
OworCXJldHVybiBhdG1lbF9wd21fcmVhZGwoY2hpcCwgYmFzZSArIG9mZnNldCk7CiB9CiAKIHN0
YXRpYyBpbmxpbmUgdm9pZCBhdG1lbF9wd21fY2hfd3JpdGVsKHN0cnVjdCBhdG1lbF9wd21fY2hp
cCAqY2hpcCwKQEAgLTEyMCw3ICsxMjAsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgYXRtZWxfcHdt
X2NoX3dyaXRlbChzdHJ1Y3QgYXRtZWxfcHdtX2NoaXAgKmNoaXAsCiB7CiAJdW5zaWduZWQgbG9u
ZyBiYXNlID0gUFdNX0NIX1JFR19PRkZTRVQgKyBjaCAqIFBXTV9DSF9SRUdfU0laRTsKIAotCXdy
aXRlbF9yZWxheGVkKHZhbCwgY2hpcC0+YmFzZSArIGJhc2UgKyBvZmZzZXQpOworCWF0bWVsX3B3
bV93cml0ZWwoY2hpcCwgYmFzZSArIG9mZnNldCwgdmFsKTsKIH0KIAogc3RhdGljIGludCBhdG1l
bF9wd21fY2FsY3VsYXRlX2NwcmRfYW5kX3ByZXMoc3RydWN0IHB3bV9jaGlwICpjaGlwLAotLSAK
Mi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtYXJtLWtlcm5lbAo=
