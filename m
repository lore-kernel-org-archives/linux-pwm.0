From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH v2 1/3] pwm: rockchip: Don't update the state for the caller
 of pwm_apply_state()
Date: Tue, 12 Mar 2019 22:46:03 +0100
Message-ID: <20190312214605.10223-2-u.kleine-koenig@pengutronix.de>
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

VGhlIHB3bS1yb2NrY2hpcCBkcml2ZXIgaXMgb25lIG9mIG9ubHkgdHdvIFBXTSBkcml2ZXJzIHdo
aWNoIHVwZGF0ZXMgdGhlCnN0YXRlIGZvciB0aGUgY2FsbGVyIG9mIHB3bV9hcHBseV9zdGF0ZSgp
LiBUaGlzIG1pZ2h0IGhhdmUgc3VycHJpc2luZwpyZXN1bHRzIGlmIHRoZSBjYWxsZXIgcmV1c2Vz
IHRoZSB2YWx1ZXMgZXhwZWN0aW5nIHRoZW0gdG8gc3RpbGwKcmVwcmVzZW50IHRoZSBzYW1lIHN0
YXRlLiBBbHNvIG5vdGUgdGhhdCB0aGlzIGZlZWRiYWNrIHdhcyBpbmNvbXBsZXRlIGFzCnRoZSBt
YXRjaGluZyBzdHJ1Y3QgcHdtX2RldmljZTo6c3RhdGUgd2Fzbid0IHVwZGF0ZWQgYW5kIHNvCnB3
bV9nZXRfc3RhdGUgc3RpbGwgcmV0dXJuZWQgdGhlIG9yaWdpbmFsbHkgcmVxdWVzdGVkIHN0YXRl
LgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5n
dXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL3B3bS9wd20tcm9ja2NoaXAuYyB8IDYgLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9w
d20tcm9ja2NoaXAuYyBiL2RyaXZlcnMvcHdtL3B3bS1yb2NrY2hpcC5jCmluZGV4IDRkOTlkNDY4
ZGYwOS4uMTYxODZiY2Q5OWUwIDEwMDY0NAotLS0gYS9kcml2ZXJzL3B3bS9wd20tcm9ja2NoaXAu
YworKysgYi9kcml2ZXJzL3B3bS9wd20tcm9ja2NoaXAuYwpAQCAtMjE1LDEyICsyMTUsNiBAQCBz
dGF0aWMgaW50IHJvY2tjaGlwX3B3bV9hcHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAsIHN0cnVj
dCBwd21fZGV2aWNlICpwd20sCiAJCQlnb3RvIG91dDsKIAl9CiAKLQkvKgotCSAqIFVwZGF0ZSB0
aGUgc3RhdGUgd2l0aCB0aGUgcmVhbCBoYXJkd2FyZSwgd2hpY2ggY2FuIGRpZmZlciBhIGJpdAot
CSAqIGJlY2F1c2Ugb2YgcGVyaW9kL2R1dHlfY3ljbGUgYXBwcm94aW1hdGlvbi4KLQkgKi8KLQly
b2NrY2hpcF9wd21fZ2V0X3N0YXRlKGNoaXAsIHB3bSwgc3RhdGUpOwotCiBvdXQ6CiAJY2xrX2Rp
c2FibGUocGMtPnBjbGspOwogCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QKTGludXgt
cm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
