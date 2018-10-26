From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Subject: [PATCH 4/4] bus: ts-nbus: weaken driver dependency to allow broader
 compile testing
Date: Fri, 26 Oct 2018 20:41:58 +0200
Message-ID: <20181026184157.16371-4-u.kleine-koenig@pengutronix.de>
References: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181026184157.16371-1-u.kleine-koenig@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>, Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>
Cc: linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-pwm@vger.kernel.org

VGhlcmUgaXMgbm90aGluZyBzcGVjaWZpYyBmb3IgdGhlIGkuTVgyOCBTb0MgaW4gdGhlIHRzLW5i
dXMgZHJpdmVyIGFuZAppdCBjb21waWxlcyBqdXN0IGZpbmUgd2l0aCBhbiBBUk0vczNjMjR4eCBj
b25maWd1cmF0aW9uLgoKU2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHUua2xlaW5l
LWtvZW5pZ0BwZW5ndXRyb25peC5kZT4KLS0tCiBkcml2ZXJzL2J1cy9LY29uZmlnIHwgMiArLQog
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9idXMvS2NvbmZpZyBiL2RyaXZlcnMvYnVzL0tjb25maWcKaW5kZXggMTg1MTEx
MmNjYzI5Li5iZjFmNDNiODQ3ZTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvYnVzL0tjb25maWcKKysr
IGIvZHJpdmVycy9idXMvS2NvbmZpZwpAQCAtMTQ5LDcgKzE0OSw3IEBAIGNvbmZpZyBUSV9TWVND
CiAKIGNvbmZpZyBUU19OQlVTCiAJdHJpc3RhdGUgIlRlY2hub2xvZ2ljIFN5c3RlbXMgTkJVUyBE
cml2ZXIiCi0JZGVwZW5kcyBvbiBTT0NfSU1YMjgKKwlkZXBlbmRzIG9uIFNPQ19JTVgyOCB8fCBD
T01QSUxFX1RFU1QKIAlkZXBlbmRzIG9uIE9GX0dQSU8gJiYgUFdNCiAJaGVscAogCSAgRHJpdmVy
IGZvciB0aGUgVGVjaG5vbG9naWMgU3lzdGVtcyBOQlVTIHdoaWNoIGlzIHVzZWQgdG8gaW50ZXJm
YWNlCi0tIAoyLjE5LjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC1hcm0ta2VybmVsCg==
