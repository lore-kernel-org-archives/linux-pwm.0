From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: [PATCH 1/2] pwm: rockchip: Don't update the state for the caller of
 pwm_apply_state()
Date: Tue, 12 Mar 2019 09:35:36 +0100
Message-ID: <20190312083537.23748-2-u.kleine-koenig@pengutronix.de>
References: <20190312083537.23748-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190312083537.23748-1-u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Cc: linux-pwm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pwm@vger.kernel.org

VGhlIHB3bS1yb2NrY2hpcCBkcml2ZXIgaXMgdGhlIG9ubHkgUFdNIGRyaXZlciB3aGljaCB1cGRh
dGVzIHRoZSBzdGF0ZQpmb3IgdGhlIGNhbGxlciBvZiBwd21fYXBwbHlfc3RhdGUoKS4gVGhpcyBt
aWdodCBoYXZlIHN1cnByaXNpbmcgcmVzdWx0cwppZiB0aGUgY2FsbGVyIHJldXNlcyB0aGUgdmFs
dWVzIGV4cGVjdGluZyB0aGVtIHRvIHN0aWxsIHJlcHJlc2VudCB0aGUKc2FtZSBzdGF0ZS4gQWxz
byBub3RlIHRoYXQgdGhpcyBmZWVkYmFjayB3YXMgaW5jb21wbGV0ZSBhcyB0aGUgbWF0Y2hpbmcK
c3RydWN0IHB3bV9kZXZpY2U6OnN0YXRlIHdhc24ndCB1cGRhdGVkIGFuZCBzbyBwd21fZ2V0X3N0
YXRlIHN0aWxsCnJldHVybmVkIHRoZSBvcmlnaW5hbGx5IHJlcXVlc3RlZCBzdGF0ZS4KClNpZ25l
ZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1LmtsZWluZS1rb2VuaWdAcGVuZ3V0cm9uaXgu
ZGU+Ci0tLQogZHJpdmVycy9wd20vcHdtLXJvY2tjaGlwLmMgfCA2IC0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLXJvY2tj
aGlwLmMgYi9kcml2ZXJzL3B3bS9wd20tcm9ja2NoaXAuYwppbmRleCA0ZDk5ZDQ2OGRmMDkuLjE2
MTg2YmNkOTllMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9wd20vcHdtLXJvY2tjaGlwLmMKKysrIGIv
ZHJpdmVycy9wd20vcHdtLXJvY2tjaGlwLmMKQEAgLTIxNSwxMiArMjE1LDYgQEAgc3RhdGljIGlu
dCByb2NrY2hpcF9wd21fYXBwbHkoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2Rl
dmljZSAqcHdtLAogCQkJZ290byBvdXQ7CiAJfQogCi0JLyoKLQkgKiBVcGRhdGUgdGhlIHN0YXRl
IHdpdGggdGhlIHJlYWwgaGFyZHdhcmUsIHdoaWNoIGNhbiBkaWZmZXIgYSBiaXQKLQkgKiBiZWNh
dXNlIG9mIHBlcmlvZC9kdXR5X2N5Y2xlIGFwcHJveGltYXRpb24uCi0JICovCi0Jcm9ja2NoaXBf
cHdtX2dldF9zdGF0ZShjaGlwLCBwd20sIHN0YXRlKTsKLQogb3V0OgogCWNsa19kaXNhYmxlKHBj
LT5wY2xrKTsKIAotLSAKMi4yMC4xCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KTGludXgtcm9ja2NoaXAgbWFpbGluZyBsaXN0CkxpbnV4LXJvY2tjaGlw
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1yb2NrY2hpcAo=
