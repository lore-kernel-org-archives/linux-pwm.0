From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 15/73] pwm: imx27: Fix clock handling in
 pwm_imx27_apply()
Date: Sat, 18 Apr 2020 09:47:17 -0400
Message-ID: <20200418134815.6519-15-sashal@kernel.org>
References: <20200418134815.6519-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org>
In-Reply-To: <20200418134815.6519-1-sashal@kernel.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane-mx.org@lists.infradead.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
List-Id: linux-pwm@vger.kernel.org

RnJvbTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5lLWtvZW5pZ0BwZW5ndXRyb25peC5kZT4K
ClsgVXBzdHJlYW0gY29tbWl0IDE1ZDRkYmQ2MDE1OTE4NTg2MTExODRmOWRkZWI1YmYyMTU2OTE1
OWMgXQoKcHdtX2lteDI3X2FwcGx5KCkgZW5hYmxlcyB0aGUgY2xvY2tzIGlmIHRoZSBwcmV2aW91
cyBQV00gc3RhdGUgd2FzCmRpc2FibGVkLiBHaXZlbiB0aGF0IHRoZSBjbG9ja3MgYXJlIHN1cHBv
c2VkIHRvIGJlIGxlZnQgb24gaWZmIHRoZSBQV00KaXMgcnVubmluZywgdGhlIGRlY2lzaW9uIHRv
IGRpc2FibGUgdGhlIGNsb2NrcyBhdCB0aGUgZW5kIG9mIHRoZQpmdW5jdGlvbiBtdXN0IG5vdCBk
ZXBlbmQgb24gdGhlIHByZXZpb3VzIHN0YXRlLgoKV2l0aG91dCB0aGlzIGZpeCB0aGUgZW5hYmxl
IGNvdW50IG9mIHRoZSB0d28gYWZmZWN0ZWQgY2xvY2tzIGluY3JlYXNlcwpieSBvbmUgd2hlbmV2
ZXIgLT5hcHBseSgpIGNoYW5nZXMgZnJvbSBvbmUgZGlzYWJsZWQgc3RhdGUgdG8gYW5vdGhlci4K
CkZpeGVzOiBiZDg4ZDMxOWFiZTkgKCJwd206IGlteDI3OiBVbmNvbmRpdGlvbmFsbHkgd3JpdGUg
c3RhdGUgdG8gaGFyZHdhcmUiKQpTaWduZWQtb2ZmLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5r
bGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBUaGllcnJ5IFJlZGlu
ZyA8dGhpZXJyeS5yZWRpbmdAZ21haWwuY29tPgpTaWduZWQtb2ZmLWJ5OiBTYXNoYSBMZXZpbiA8
c2FzaGFsQGtlcm5lbC5vcmc+Ci0tLQogZHJpdmVycy9wd20vcHdtLWlteDI3LmMgfCAyICstCiAx
IGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3B3bS9wd20taW14MjcuYyBiL2RyaXZlcnMvcHdtL3B3bS1pbXgyNy5jCmluZGV4
IDM1YTdhYzQyMjY5YzIuLjdlNWVkMDE1Mjk3NzMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcHdtL3B3
bS1pbXgyNy5jCisrKyBiL2RyaXZlcnMvcHdtL3B3bS1pbXgyNy5jCkBAIC0yODksNyArMjg5LDcg
QEAgc3RhdGljIGludCBwd21faW14MjdfYXBwbHkoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1
Y3QgcHdtX2RldmljZSAqcHdtLAogCiAJd3JpdGVsKGNyLCBpbXgtPm1taW9fYmFzZSArIE1YM19Q
V01DUik7CiAKLQlpZiAoIXN0YXRlLT5lbmFibGVkICYmIGNzdGF0ZS5lbmFibGVkKQorCWlmICgh
c3RhdGUtPmVuYWJsZWQpCiAJCXB3bV9pbXgyN19jbGtfZGlzYWJsZV91bnByZXBhcmUoY2hpcCk7
CiAKIAlyZXR1cm4gMDsKLS0gCjIuMjAuMQoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
