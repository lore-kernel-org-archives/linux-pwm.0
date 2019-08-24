From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe-rXY34ruvC2xidJT2blvkqNi2O/JbrIOy@public.gmane.org>
Subject: [PATCH v3 3/6] pwm: rockchip: Don't update the state for the caller
 of pwm_apply_state()
Date: Sat, 24 Aug 2019 17:37:04 +0200
Message-ID: <20190824153707.13746-4-uwe@kleine-koenig.org>
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
ClRoZSBwd20tcm9ja2NoaXAgZHJpdmVyIGlzIG9uZSBvZiBvbmx5IHRocmVlIFBXTSBkcml2ZXJz
IHdoaWNoIHVwZGF0ZXMKdGhlIHN0YXRlIGZvciB0aGUgY2FsbGVyIG9mIHB3bV9hcHBseV9zdGF0
ZSgpLiBUaGlzIG1pZ2h0IGhhdmUKc3VycHJpc2luZyByZXN1bHRzIGlmIHRoZSBjYWxsZXIgcmV1
c2VzIHRoZSB2YWx1ZXMgZXhwZWN0aW5nIHRoZW0gdG8Kc3RpbGwgcmVwcmVzZW50IHRoZSBzYW1l
IHN0YXRlLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5p
Z0BwZW5ndXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL3B3bS9wd20tcm9ja2NoaXAuYyB8IDYgLS0t
LS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJz
L3B3bS9wd20tcm9ja2NoaXAuYyBiL2RyaXZlcnMvcHdtL3B3bS1yb2NrY2hpcC5jCmluZGV4IDUx
Yjk2Y2I3ZGQyNS4uY2M1MDJjOGQ3ZTljIDEwMDY0NAotLS0gYS9kcml2ZXJzL3B3bS9wd20tcm9j
a2NoaXAuYworKysgYi9kcml2ZXJzL3B3bS9wd20tcm9ja2NoaXAuYwpAQCAtMjEyLDEyICsyMTIs
NiBAQCBzdGF0aWMgaW50IHJvY2tjaGlwX3B3bV9hcHBseShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAs
IHN0cnVjdCBwd21fZGV2aWNlICpwd20sCiAJCQlnb3RvIG91dDsKIAl9CiAKLQkvKgotCSAqIFVw
ZGF0ZSB0aGUgc3RhdGUgd2l0aCB0aGUgcmVhbCBoYXJkd2FyZSwgd2hpY2ggY2FuIGRpZmZlciBh
IGJpdAotCSAqIGJlY2F1c2Ugb2YgcGVyaW9kL2R1dHlfY3ljbGUgYXBwcm94aW1hdGlvbi4KLQkg
Ki8KLQlyb2NrY2hpcF9wd21fZ2V0X3N0YXRlKGNoaXAsIHB3bSwgc3RhdGUpOwotCiBvdXQ6CiAJ
Y2xrX2Rpc2FibGUocGMtPnBjbGspOwogCi0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eC1yb2NrY2hpcCBtYWlsaW5nIGxpc3QK
TGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXJvY2tjaGlwCg==
