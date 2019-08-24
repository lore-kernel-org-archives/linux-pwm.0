From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Subject: [PATCH v3 4/6] pwm: sun4i: Don't update the state for the caller of
 pwm_apply_state()
Date: Sat, 24 Aug 2019 17:37:05 +0200
Message-ID: <20190824153707.13746-5-uwe@kleine-koenig.org>
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
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
ClRoZSBwd20tc3VuNGkgZHJpdmVyIGlzIG9uZSBvZiBvbmx5IHRocmVlIFBXTSBkcml2ZXJzIHdo
aWNoIHVwZGF0ZXMgdGhlCnN0YXRlIGZvciB0aGUgY2FsbGVyIG9mIHB3bV9hcHBseV9zdGF0ZSgp
LiBUaGlzIG1pZ2h0IGhhdmUgc3VycHJpc2luZwpyZXN1bHRzIGlmIHRoZSBjYWxsZXIgcmV1c2Vz
IHRoZSB2YWx1ZXMgZXhwZWN0aW5nIHRoZW0gdG8gc3RpbGwKcmVwcmVzZW50IHRoZSBzYW1lIHN0
YXRlLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0Bw
ZW5ndXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL3B3bS9wd20tc3VuNGkuYyB8IDYgLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9w
d20tc3VuNGkuYyBiL2RyaXZlcnMvcHdtL3B3bS1zdW40aS5jCmluZGV4IGRlNzhjODI0YmJmZC4u
MzkwMDdhN2MwZDgzIDEwMDY0NAotLS0gYS9kcml2ZXJzL3B3bS9wd20tc3VuNGkuYworKysgYi9k
cml2ZXJzL3B3bS9wd20tc3VuNGkuYwpAQCAtMTkyLDEyICsxOTIsNiBAQCBzdGF0aWMgaW50IHN1
bjRpX3B3bV9jYWxjdWxhdGUoc3RydWN0IHN1bjRpX3B3bV9jaGlwICpzdW40aV9wd20sCiAJKmR0
eSA9IGRpdjsKIAkqcHJzY2xyID0gcHJlc2NhbGVyOwogCi0JZGl2ID0gKHU2NClwdmFsICogTlNF
Q19QRVJfU0VDICogKnByZDsKLQlzdGF0ZS0+cGVyaW9kID0gRElWX1JPVU5EX0NMT1NFU1RfVUxM
KGRpdiwgY2xrX3JhdGUpOwotCi0JZGl2ID0gKHU2NClwdmFsICogTlNFQ19QRVJfU0VDICogKmR0
eTsKLQlzdGF0ZS0+ZHV0eV9jeWNsZSA9IERJVl9ST1VORF9DTE9TRVNUX1VMTChkaXYsIGNsa19y
YXRlKTsKLQogCXJldHVybiAwOwogfQogCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QK
TGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
