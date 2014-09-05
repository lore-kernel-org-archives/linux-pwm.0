From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <gael.portay@gmail.com>
Subject: [PATCHv3 1/4] ARM: at91/tclib: prefer using of devm_* functions
Date: Fri,  5 Sep 2014 16:14:37 +0200
Message-ID: <1409926480-16367-2-git-send-email-gael.portay@gmail.com>
References: <1409926480-16367-1-git-send-email-gael.portay@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1409926480-16367-1-git-send-email-gael.portay@gmail.com>
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

U2lnbmVkLW9mZi1ieTogR2HDq2wgUE9SVEFZIDxnYWVsLnBvcnRheUBnbWFpbC5jb20+CkFja2Vk
LWJ5OiBCb3JpcyBCcmV6aWxsb24gPGJvcmlzLmJyZXppbGxvbkBmcmVlLWVsZWN0cm9ucy5jb20+
Ci0tLQogZHJpdmVycy9taXNjL2F0bWVsX3RjbGliLmMgfCAxNCArKysrKystLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL21pc2MvYXRtZWxfdGNsaWIuYyBiL2RyaXZlcnMvbWlzYy9hdG1lbF90Y2xpYi5j
CmluZGV4IGM4ZDhlMzguLmI1MTRhMmQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbWlzYy9hdG1lbF90
Y2xpYi5jCisrKyBiL2RyaXZlcnMvbWlzYy9hdG1lbF90Y2xpYi5jCkBAIC0xNTAsMTcgKzE1MCwx
NSBAQCBzdGF0aWMgaW50IF9faW5pdCB0Y19wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQogCWlmIChpcnEgPCAwKQogCQlyZXR1cm4gLUVJTlZBTDsKIAotCXRjID0ga3phbGxvYyhz
aXplb2Yoc3RydWN0IGF0bWVsX3RjKSwgR0ZQX0tFUk5FTCk7CisJdGMgPSBkZXZtX2t6YWxsb2Mo
JnBkZXYtPmRldiwgc2l6ZW9mKHN0cnVjdCBhdG1lbF90YyksIEdGUF9LRVJORUwpOwogCWlmICgh
dGMpCiAJCXJldHVybiAtRU5PTUVNOwogCiAJdGMtPnBkZXYgPSBwZGV2OwogCi0JY2xrID0gY2xr
X2dldCgmcGRldi0+ZGV2LCAidDBfY2xrIik7Ci0JaWYgKElTX0VSUihjbGspKSB7Ci0JCWtmcmVl
KHRjKTsKLQkJcmV0dXJuIC1FSU5WQUw7Ci0JfQorCWNsayA9IGRldm1fY2xrX2dldCgmcGRldi0+
ZGV2LCAidDBfY2xrIik7CisJaWYgKElTX0VSUihjbGspKQorCQlyZXR1cm4gUFRSX0VSUihjbGsp
OwogCiAJLyogTm93IHRha2UgU29DIGluZm9ybWF0aW9uIGlmIGF2YWlsYWJsZSAqLwogCWlmIChw
ZGV2LT5kZXYub2Zfbm9kZSkgewpAQCAtMTcxLDEwICsxNjksMTAgQEAgc3RhdGljIGludCBfX2lu
aXQgdGNfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKIAl9CiAKIAl0Yy0+Y2xr
WzBdID0gY2xrOwotCXRjLT5jbGtbMV0gPSBjbGtfZ2V0KCZwZGV2LT5kZXYsICJ0MV9jbGsiKTsK
Kwl0Yy0+Y2xrWzFdID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsICJ0MV9jbGsiKTsKIAlpZiAo
SVNfRVJSKHRjLT5jbGtbMV0pKQogCQl0Yy0+Y2xrWzFdID0gY2xrOwotCXRjLT5jbGtbMl0gPSBj
bGtfZ2V0KCZwZGV2LT5kZXYsICJ0Ml9jbGsiKTsKKwl0Yy0+Y2xrWzJdID0gZGV2bV9jbGtfZ2V0
KCZwZGV2LT5kZXYsICJ0Ml9jbGsiKTsKIAlpZiAoSVNfRVJSKHRjLT5jbGtbMl0pKQogCQl0Yy0+
Y2xrWzJdID0gY2xrOwogCi0tIAoxLjkuMwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
