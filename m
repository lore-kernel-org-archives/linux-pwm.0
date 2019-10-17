From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] pwm: bcm-iproc: prevent unloading the driver module while in
 use
Date: Thu, 17 Oct 2019 21:22:18 +0200
Message-ID: <20191017192218.9042-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>
Cc: linux-pwm@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

VGhlIG93bmVyIG1lbWJlciBvZiBzdHJ1Y3QgcHdtX29wcyBtdXN0IGJlIHNldCB0byBUSElTX01P
RFVMRSB0bwppbmNyZWFzZSB0aGUgcmVmZXJlbmNlIGNvdW50IG9mIHRoZSBtb2R1bGUgc3VjaCB0
aGF0IHRoZSBtb2R1bGUgY2Fubm90CmJlIHJlbW92ZWQgd2hpbGUgaXRzIGNvZGUgaXMgaW4gdXNl
LgoKRml4ZXM6IGRhYTVhYmM0MWM4MCAoInB3bTogQWRkIHN1cHBvcnQgZm9yIEJyb2FkY29tIGlQ
cm9jIFBXTSBjb250cm9sbGVyIikKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUu
a2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL3B3bS9wd20tYmNtLWlw
cm9jLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcHdtL3B3bS1iY20taXByb2MuYyBiL2RyaXZlcnMvcHdtL3B3bS1iY20taXByb2Mu
YwppbmRleCA1NmMzOGNmYWU5MmMuLjFmODI5ZWRkOGVlNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9w
d20vcHdtLWJjbS1pcHJvYy5jCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1iY20taXByb2MuYwpAQCAt
MTg3LDYgKzE4Nyw3IEBAIHN0YXRpYyBpbnQgaXByb2NfcHdtY19hcHBseShzdHJ1Y3QgcHdtX2No
aXAgKmNoaXAsIHN0cnVjdCBwd21fZGV2aWNlICpwd20sCiBzdGF0aWMgY29uc3Qgc3RydWN0IHB3
bV9vcHMgaXByb2NfcHdtX29wcyA9IHsKIAkuYXBwbHkgPSBpcHJvY19wd21jX2FwcGx5LAogCS5n
ZXRfc3RhdGUgPSBpcHJvY19wd21jX2dldF9zdGF0ZSwKKwkub3duZXIgPSBUSElTX01PRFVMRSwK
IH07CiAKIHN0YXRpYyBpbnQgaXByb2NfcHdtY19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNl
ICpwZGV2KQotLSAKMi4yMy4wCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5l
bEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4v
bGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
