From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Subject: [PATCH v3 5/6] pwm: fsl-ftm: Don't update the state for the caller of
 pwm_apply_state()
Date: Sat, 24 Aug 2019 17:37:06 +0200
Message-ID: <20190824153707.13746-6-uwe@kleine-koenig.org>
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

VGhlIHB3bS1mc2wtZnRtIGRyaXZlciBpcyBvbmUgb2Ygb25seSB0aHJlZSBQV00gZHJpdmVycyB3
aGljaCB1cGRhdGVzCnRoZSBzdGF0ZSBmb3IgdGhlIGNhbGxlciBvZiBwd21fYXBwbHlfc3RhdGUo
KS4gVGhpcyBtaWdodCBoYXZlCnN1cnByaXNpbmcgcmVzdWx0cyBpZiB0aGUgY2FsbGVyIHJldXNl
cyB0aGUgdmFsdWVzIGV4cGVjdGluZyB0aGVtIHRvCnN0aWxsIHJlcHJlc2VudCB0aGUgc2FtZSBz
dGF0ZS4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5p
Zy5vcmc+Ci0tLQogZHJpdmVycy9wd20vcHdtLWZzbC1mdG0uYyB8IDQgLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWZzbC1m
dG0uYyBiL2RyaXZlcnMvcHdtL3B3bS1mc2wtZnRtLmMKaW5kZXggOWQzMWEyMTcxMTFkLi4zYzk3
Mzg2MTdjZWIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcHdtL3B3bS1mc2wtZnRtLmMKKysrIGIvZHJp
dmVycy9wd20vcHdtLWZzbC1mdG0uYwpAQCAtMjkyLDEwICsyOTIsNiBAQCBzdGF0aWMgaW50IGZz
bF9wd21fYXBwbHlfY29uZmlnKHN0cnVjdCBmc2xfcHdtX2NoaXAgKmZwYywKIAogCXJlZ21hcF91
cGRhdGVfYml0cyhmcGMtPnJlZ21hcCwgRlRNX1BPTCwgQklUKHB3bS0+aHdwd20pLCByZWdfcG9s
YXJpdHkpOwogCi0JbmV3c3RhdGUtPnBlcmlvZCA9IGZzbF9wd21fdGlja3NfdG9fbnMoZnBjLAot
CQkJCQkgICAgICAgZnBjLT5wZXJpb2QubW9kX3BlcmlvZCArIDEpOwotCW5ld3N0YXRlLT5kdXR5
X2N5Y2xlID0gZnNsX3B3bV90aWNrc190b19ucyhmcGMsIGR1dHkpOwotCiAJZnRtX3NldF93cml0
ZV9wcm90ZWN0aW9uKGZwYyk7CiAKIAlyZXR1cm4gMDsKLS0gCjIuMjAuMQoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkxpbnV4LXJvY2tjaGlwIG1haWxp
bmcgbGlzdApMaW51eC1yb2NrY2hpcEBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtcm9ja2NoaXAK
