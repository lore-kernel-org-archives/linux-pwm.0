From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 2/3] pwm: sun4i: Don't update the state for the caller of
 pwm_apply_state()
Date: Tue, 12 Mar 2019 22:46:04 +0100
Message-ID: <20190312214605.10223-3-u.kleine-koenig@pengutronix.de>
References: <20190312214605.10223-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190312214605.10223-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Maxime Ripard <maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

VGhlIHB3bS1zdW40aSBkcml2ZXIgaXMgb25lIG9mIG9ubHkgdHdvIFBXTSBkcml2ZXJzIHdoaWNo
IHVwZGF0ZXMgdGhlCnN0YXRlIGZvciB0aGUgY2FsbGVyIG9mIHB3bV9hcHBseV9zdGF0ZSgpLiBU
aGlzIG1pZ2h0IGhhdmUgc3VycHJpc2luZwpyZXN1bHRzIGlmIHRoZSBjYWxsZXIgcmV1c2VzIHRo
ZSB2YWx1ZXMgZXhwZWN0aW5nIHRoZW0gdG8gc3RpbGwKcmVwcmVzZW50IHRoZSBzYW1lIHN0YXRl
LiBBbHNvIG5vdGUgdGhhdCB0aGlzIGZlZWRiYWNrIHdhcyBpbmNvbXBsZXRlIGFzCnRoZSBtYXRj
aGluZyBzdHJ1Y3QgcHdtX2RldmljZTo6c3RhdGUgd2Fzbid0IHVwZGF0ZWQgYW5kIHNvCnB3bV9n
ZXRfc3RhdGUgc3RpbGwgcmV0dXJuZWQgdGhlIG9yaWdpbmFsbHkgcmVxdWVzdGVkIHN0YXRlLgoK
U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRy
b25peC5kZT4KLS0tCiBkcml2ZXJzL3B3bS9wd20tc3VuNGkuYyB8IDYgLS0tLS0tCiAxIGZpbGUg
Y2hhbmdlZCwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tc3Vu
NGkuYyBiL2RyaXZlcnMvcHdtL3B3bS1zdW40aS5jCmluZGV4IDQ3MGQ0ZjcxZTdlYi4uMTQyYTYw
M2ZlN2VhIDEwMDY0NAotLS0gYS9kcml2ZXJzL3B3bS9wd20tc3VuNGkuYworKysgYi9kcml2ZXJz
L3B3bS9wd20tc3VuNGkuYwpAQCAtMTkzLDEyICsxOTMsNiBAQCBzdGF0aWMgaW50IHN1bjRpX3B3
bV9jYWxjdWxhdGUoc3RydWN0IHN1bjRpX3B3bV9jaGlwICpzdW40aV9wd20sCiAJKmR0eSA9IGRp
djsKIAkqcHJzY2xyID0gcHJlc2NhbGVyOwogCi0JZGl2ID0gKHU2NClwdmFsICogTlNFQ19QRVJf
U0VDICogKnByZDsKLQlzdGF0ZS0+cGVyaW9kID0gRElWX1JPVU5EX0NMT1NFU1RfVUxMKGRpdiwg
Y2xrX3JhdGUpOwotCi0JZGl2ID0gKHU2NClwdmFsICogTlNFQ19QRVJfU0VDICogKmR0eTsKLQlz
dGF0ZS0+ZHV0eV9jeWNsZSA9IERJVl9ST1VORF9DTE9TRVNUX1VMTChkaXYsIGNsa19yYXRlKTsK
LQogCXJldHVybiAwOwogfQogCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgt
cm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
