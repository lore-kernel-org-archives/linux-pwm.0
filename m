From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH 4/3] pwm: atmel: document known weaknesses of both hardware
 and software
Date: Fri, 16 Aug 2019 11:37:48 +0200
Message-ID: <20190816093748.11769-1-uwe@kleine-koenig.org>
References: <20190815214133.11134-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190815214133.11134-1-uwe@kleine-koenig.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Claudiu Beznea <claudiu.beznea@microchip.com>, Thierry Reding <thierry.reding@gmail.com>
Cc: linux-pwm@vger.kernel.org, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

U2lnbmVkLW9mZi1ieTogVXdlIEtsZWluZS1Lw7ZuaWcgPHV3ZUBrbGVpbmUta29lbmlnLm9yZz4K
LS0tCiBkcml2ZXJzL3B3bS9wd20tYXRtZWwuYyB8IDEwICsrKysrKysrKysKIDEgZmlsZSBjaGFu
Z2VkLCAxMCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wd20vcHdtLWF0bWVs
LmMgYi9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYwppbmRleCA0MmZlN2JjMDQzYTguLjFkZGI5M2Ri
OTYyNyAxMDA2NDQKLS0tIGEvZHJpdmVycy9wd20vcHdtLWF0bWVsLmMKKysrIGIvZHJpdmVycy9w
d20vcHdtLWF0bWVsLmMKQEAgLTcsNiArNywxNiBAQAogICoKICAqIFJlZmVyZW5jZSBtYW51YWwg
Zm9yICJhdG1lbCxhdDkxc2FtOXJsLXB3bSI6CiAgKiAgIGh0dHA6Ly93dzEubWljcm9jaGlwLmNv
bS9kb3dubG9hZHMvZW4vRGV2aWNlRG9jL0F0bWVsLTExMDMyLTMyLWJpdC1BUk05MjZFSi1TLU1p
Y3JvY29udHJvbGxlci1TQU05RzI1X0RhdGFzaGVldC5wZGYKKyAqCisgKiBMaW1pdGF0aW9uczoK
KyAqIC0gUGVyaW9kcyBzdGFydCB3aXRoIHRoZSBpbmFjdGl2ZSBsZXZlbC4KKyAqIC0gSGFyZHdh
cmUgaGFzIHRvIGJlIHN0b3BwZWQgaW4gZ2VuZXJhbCB0byB1cGRhdGUgc2V0dGluZ3MuCisgKgor
ICogU29mdHdhcmUgYnVncy9wb3NzaWJsZSBpbXByb3ZlbWVudHM6CisgKiAtIFdoZW4gYXRtZWxf
cHdtX2FwcGx5KCkgaXMgY2FsbGVkIHdpdGggc3RhdGUtPmVuYWJsZWQ9ZmFsc2UgYSBjaGFuZ2Ug
aW4KKyAqICAgc3RhdGUtPnBvbGFyaXR5IGlzbid0IGhvbm9yZWQuCisgKiAtIEluc3RlYWQgb2Yg
c2xlZXBpbmcgdG8gd2FpdCBmb3IgYSBjb21wbGV0ZWQgcGVyaW9kLCB0aGUgaW50ZXJydXB0Cisg
KiAgIGZ1bmN0aW9uYWxpdHkgY291bGQgYmUgdXNlZC4KICAqLwogCiAjaW5jbHVkZSA8bGludXgv
Y2xrLmg+Ci0tIAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
