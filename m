From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <g.portay@overkiz.com>
Subject: [PATCHv2 1/4] ARM: at91/tclib: prefer using of devm_* functions
Date: Fri, 29 Aug 2014 18:16:40 +0200
Message-ID: <1409329003-17252-2-git-send-email-g.portay@overkiz.com>
References: <1409329003-17252-1-git-send-email-g.portay@overkiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409329003-17252-1-git-send-email-g.portay@overkiz.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Daniel Lezcano <daniel.lezcano@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Thomas Gleixner <tglx@linutronix.de>, Thierry Reding <thierry.reding@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: =?utf-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@gmail.com>
List-Id: linux-pwm@vger.kernel.org

RnJvbTogR2HDq2wgUE9SVEFZIDxnYWVsLnBvcnRheUBnbWFpbC5jb20+CgpTaWduZWQtb2ZmLWJ5
OiBHYcOrbCBQT1JUQVkgPGdhZWwucG9ydGF5QGdtYWlsLmNvbT4KQWNrZWQtYnk6IEJvcmlzIEJy
ZXppbGxvbiA8Ym9yaXMuYnJlemlsbG9uQGZyZWUtZWxlY3Ryb25zLmNvbT4KLS0tCiBkcml2ZXJz
L21pc2MvYXRtZWxfdGNsaWIuYyB8IDE0ICsrKysrKy0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NiBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWlz
Yy9hdG1lbF90Y2xpYi5jIGIvZHJpdmVycy9taXNjL2F0bWVsX3RjbGliLmMKaW5kZXggYzhkOGUz
OC4uYjUxNGEyZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9taXNjL2F0bWVsX3RjbGliLmMKKysrIGIv
ZHJpdmVycy9taXNjL2F0bWVsX3RjbGliLmMKQEAgLTE1MCwxNyArMTUwLDE1IEBAIHN0YXRpYyBp
bnQgX19pbml0IHRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpCiAJaWYgKGly
cSA8IDApCiAJCXJldHVybiAtRUlOVkFMOwogCi0JdGMgPSBremFsbG9jKHNpemVvZihzdHJ1Y3Qg
YXRtZWxfdGMpLCBHRlBfS0VSTkVMKTsKKwl0YyA9IGRldm1fa3phbGxvYygmcGRldi0+ZGV2LCBz
aXplb2Yoc3RydWN0IGF0bWVsX3RjKSwgR0ZQX0tFUk5FTCk7CiAJaWYgKCF0YykKIAkJcmV0dXJu
IC1FTk9NRU07CiAKIAl0Yy0+cGRldiA9IHBkZXY7CiAKLQljbGsgPSBjbGtfZ2V0KCZwZGV2LT5k
ZXYsICJ0MF9jbGsiKTsKLQlpZiAoSVNfRVJSKGNsaykpIHsKLQkJa2ZyZWUodGMpOwotCQlyZXR1
cm4gLUVJTlZBTDsKLQl9CisJY2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJ0MF9jbGsi
KTsKKwlpZiAoSVNfRVJSKGNsaykpCisJCXJldHVybiBQVFJfRVJSKGNsayk7CiAKIAkvKiBOb3cg
dGFrZSBTb0MgaW5mb3JtYXRpb24gaWYgYXZhaWxhYmxlICovCiAJaWYgKHBkZXYtPmRldi5vZl9u
b2RlKSB7CkBAIC0xNzEsMTAgKzE2OSwxMCBAQCBzdGF0aWMgaW50IF9faW5pdCB0Y19wcm9iZShz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQogCX0KIAogCXRjLT5jbGtbMF0gPSBjbGs7Ci0J
dGMtPmNsa1sxXSA9IGNsa19nZXQoJnBkZXYtPmRldiwgInQxX2NsayIpOworCXRjLT5jbGtbMV0g
PSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwgInQxX2NsayIpOwogCWlmIChJU19FUlIodGMtPmNs
a1sxXSkpCiAJCXRjLT5jbGtbMV0gPSBjbGs7Ci0JdGMtPmNsa1syXSA9IGNsa19nZXQoJnBkZXYt
PmRldiwgInQyX2NsayIpOworCXRjLT5jbGtbMl0gPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRldiwg
InQyX2NsayIpOwogCWlmIChJU19FUlIodGMtPmNsa1syXSkpCiAJCXRjLT5jbGtbMl0gPSBjbGs7
CiAKLS0gCjEuOS4zCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgtYXJtLWtlcm5lbEBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtYXJtLWtlcm5lbAo=
