From: =?UTF-8?q?Ga=C3=ABl=20PORTAY?= <g.portay@overkiz.com>
Subject: [PATCHv2 4/4] clocksource: tcb_clksrc: unprepare clock in case of
 failure
Date: Fri, 29 Aug 2014 18:16:43 +0200
Message-ID: <1409329003-17252-5-git-send-email-g.portay@overkiz.com>
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
Cc: =?utf-8?q?Ga=C3=ABl=20PORTAY?= <g.portay@overkiz.com>
List-Id: linux-pwm@vger.kernel.org

VGhlIGNsb2NrIGlzIG5vdCB1bnByZXBhcmVkIGluIGNhc2Ugb2YgdGhlIHJlcXVlc3QgSVJRIGZh
aWxzLgoKQWxzbyB1cGRhdGUgdG8gcmVxdWVzdF9pcnEuCgpTaWduZWQtb2ZmLWJ5OiBHYcOrbCBQ
T1JUQVkgPGcucG9ydGF5QG92ZXJraXouY29tPgotLS0KIGRyaXZlcnMvY2xvY2tzb3VyY2UvdGNi
X2Nsa3NyYy5jIHwgMTMgKysrKy0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9u
cygrKSwgOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2Nsb2Nrc291cmNlL3Rj
Yl9jbGtzcmMuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGNiX2Nsa3NyYy5jCmluZGV4IGY5MjJl
ODEuLjhiZGJjNDUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGNiX2Nsa3NyYy5j
CisrKyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvdGNiX2Nsa3NyYy5jCkBAIC0xNzgsMTIgKzE3OCw2
IEBAIHN0YXRpYyBpcnFyZXR1cm5fdCBjaDJfaXJxKGludCBpcnEsIHZvaWQgKmhhbmRsZSkKIAly
ZXR1cm4gSVJRX05PTkU7CiB9CiAKLXN0YXRpYyBzdHJ1Y3QgaXJxYWN0aW9uIHRjX2lycWFjdGlv
biA9IHsKLQkubmFtZQkJPSAidGNfY2xrZXZ0IiwKLQkuZmxhZ3MJCT0gSVJRRl9USU1FUiwKLQku
aGFuZGxlcgk9IGNoMl9pcnEsCi19OwotCiBzdGF0aWMgaW50IF9faW5pdCBzZXR1cF9jbGtldmVu
dHMoc3RydWN0IGF0bWVsX3RjICp0YywgaW50IGNsazMya19kaXZpc29yX2lkeCkKIHsKIAlpbnQg
cmV0OwpAQCAtMTk4LDE1ICsxOTIsMTYgQEAgc3RhdGljIGludCBfX2luaXQgc2V0dXBfY2xrZXZl
bnRzKHN0cnVjdCBhdG1lbF90YyAqdGMsIGludCBjbGszMmtfZGl2aXNvcl9pZHgpCiAKIAljbGtl
dnQucmVncyA9IHRjLT5yZWdzOwogCWNsa2V2dC5jbGsgPSB0Ml9jbGs7Ci0JdGNfaXJxYWN0aW9u
LmRldl9pZCA9ICZjbGtldnQ7CiAKIAl0aW1lcl9jbG9jayA9IGNsazMya19kaXZpc29yX2lkeDsK
IAogCWNsa2V2dC5jbGtldnQuY3B1bWFzayA9IGNwdW1hc2tfb2YoMCk7CiAKLQlyZXQgPSBzZXR1
cF9pcnEoaXJxLCAmdGNfaXJxYWN0aW9uKTsKLQlpZiAocmV0KQorCXJldCA9IHJlcXVlc3RfaXJx
KGlycSwgY2gyX2lycSwgSVJRRl9USU1FUiwgInRjX2Nsa2V2dCIsICZjbGtldnQpOworCWlmIChy
ZXQpIHsKKwkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHQyX2Nsayk7CiAJCXJldHVybiByZXQ7CisJ
fQogCiAJY2xvY2tldmVudHNfY29uZmlnX2FuZF9yZWdpc3RlcigmY2xrZXZ0LmNsa2V2dCwgMzI3
NjgsIDEsIDB4ZmZmZik7CiAKLS0gCjEuOS4zCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KbGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QKbGludXgt
YXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbAo=
