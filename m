From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Subject: [PATCH v3 2/6] pwm: let pwm_get_state() return the last implemented
 state
Date: Sat, 24 Aug 2019 17:37:03 +0200
Message-ID: <20190824153707.13746-3-uwe@kleine-koenig.org>
References: <20190824153707.13746-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190824153707.13746-1-uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Patrick Havelange <patrick.havelange-buIOx9BAs4sybS5Ee8rs3A@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

V2hlbiBwd21fYXBwbHlfc3RhdGUoKSBpcyBjYWxsZWQgdGhlIGxvd2xldmVsIGRyaXZlciB1c3Vh
bGx5IGhhcyB0bwphcHBseSBzb21lIHJvdW5kaW5nIGJlY2F1c2UgdGhlIGhhcmR3YXJlIGRvZXNu
J3Qgc3VwcG9ydCBuYW5vc2Vjb25kCnJlc29sdXRpb24uIFNvIGxldCBwd21fZ2V0X3N0YXRlKCkg
cmV0dXJuIHRoZSBhY3R1YWxseSBpbXBsZW1lbnRlZCBzdGF0ZQppbnN0ZWFkIG9mIHRoZSBsYXN0
IGFwcGxpZWQgb25lIGlmIHBvc3NpYmxlLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7Zu
aWcgPHV3ZUBrbGVpbmUta29lbmlnLm9yZz4KLS0tCiBkcml2ZXJzL3B3bS9jb3JlLmMgfCA5ICsr
KysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL2NvcmUuYyBiL2RyaXZlcnMvcHdtL2NvcmUuYwppbmRl
eCA3MjM0N2NhNGE2NDcuLjkyMzMzYjg5YmYwMiAxMDA2NDQKLS0tIGEvZHJpdmVycy9wd20vY29y
ZS5jCisrKyBiL2RyaXZlcnMvcHdtL2NvcmUuYwpAQCAtNDczLDcgKzQ3MywxNCBAQCBpbnQgcHdt
X2FwcGx5X3N0YXRlKHN0cnVjdCBwd21fZGV2aWNlICpwd20sIHN0cnVjdCBwd21fc3RhdGUgKnN0
YXRlKQogCQlpZiAoZXJyKQogCQkJcmV0dXJuIGVycjsKIAotCQlwd20tPnN0YXRlID0gKnN0YXRl
OworCQkvKgorCQkgKiAuYXBwbHkgbWlnaHQgaGF2ZSB0byByb3VuZCBzb21lIHZhbHVlcyBpbiAq
c3RhdGUsIGlmIHBvc3NpYmxlCisJCSAqIHJlYWQgdGhlIGFjdHVhbGx5IGltcGxlbWVudGVkIHZh
bHVlIGJhY2suCisJCSAqLworCQlpZiAoY2hpcC0+b3BzLT5nZXRfc3RhdGUpCisJCQljaGlwLT5v
cHMtPmdldF9zdGF0ZShjaGlwLCBwd20sICZwd20tPnN0YXRlKTsKKwkJZWxzZQorCQkJcHdtLT5z
dGF0ZSA9ICpzdGF0ZTsKIAl9IGVsc2UgewogCQkvKgogCQkgKiBGSVhNRTogcmVzdG9yZSB0aGUg
aW5pdGlhbCBzdGF0ZSBpbiBjYXNlIG9mIGVycm9yLgotLSAKMi4yMC4xCgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAgbWFpbGlu
ZyBsaXN0CkxpbnV4LXJvY2tjaGlwQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1yb2NrY2hpcAo=
