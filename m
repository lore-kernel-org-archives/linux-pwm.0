From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH] pwm: rockchip: set polarity unconditionally in .get_state()
Date: Mon,  2 Sep 2019 16:39:41 +0200
Message-ID: <20190902143941.10631-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

RG9uJ3QgcmVseSBvbiAqc3RhdGUgYmVpbmcgemVybyBpbml0aWFsaXplZCBhbmQgUFdNX1BPTEFS
SVRZX05PUk1BTApiZWluZyB6ZXJvLiBTbyBhbHdheXMgYXNzaWduIC5wb2xhcml0eS4KClNpZ25l
ZC1vZmYtYnk6IFV3ZSBLbGVpbmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+Ci0tLQog
ZHJpdmVycy9wd20vcHdtLXJvY2tjaGlwLmMgfCA4ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdt
L3B3bS1yb2NrY2hpcC5jIGIvZHJpdmVycy9wd20vcHdtLXJvY2tjaGlwLmMKaW5kZXggNTFiOTZj
YjdkZDI1Li44ZWIyZGI1OTc0MWQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcHdtL3B3bS1yb2NrY2hp
cC5jCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1yb2NrY2hpcC5jCkBAIC05MCwxMCArOTAsMTAgQEAg
c3RhdGljIHZvaWQgcm9ja2NoaXBfcHdtX2dldF9zdGF0ZShzdHJ1Y3QgcHdtX2NoaXAgKmNoaXAs
CiAJCXN0YXRlLT5lbmFibGVkID0gKCh2YWwgJiBlbmFibGVfY29uZikgPT0gZW5hYmxlX2NvbmYp
ID8KIAkJCQkgdHJ1ZSA6IGZhbHNlOwogCi0JaWYgKHBjLT5kYXRhLT5zdXBwb3J0c19wb2xhcml0
eSkgewotCQlpZiAoISh2YWwgJiBQV01fRFVUWV9QT1NJVElWRSkpCi0JCQlzdGF0ZS0+cG9sYXJp
dHkgPSBQV01fUE9MQVJJVFlfSU5WRVJTRUQ7Ci0JfQorCWlmIChwYy0+ZGF0YS0+c3VwcG9ydHNf
cG9sYXJpdHkgJiYgISh2YWwgJiBQV01fRFVUWV9QT1NJVElWRSkpCisJCXN0YXRlLT5wb2xhcml0
eSA9IFBXTV9QT0xBUklUWV9JTlZFUlNFRDsKKwllbHNlCisJCXN0YXRlLT5wb2xhcml0eSA9IFBX
TV9QT0xBUklUWV9OT1JNQUw7CiAKIAljbGtfZGlzYWJsZShwYy0+cGNsayk7CiB9Ci0tIAoyLjIz
LjAKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1h
cm0ta2VybmVsCg==
