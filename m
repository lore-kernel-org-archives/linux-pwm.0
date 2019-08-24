From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Subject: [PATCH v2 4/6] pwm: atmel: document known weaknesses of both hardware
 and software
Date: Sat, 24 Aug 2019 02:10:39 +0200
Message-ID: <20190824001041.11007-5-uwe@kleine-koenig.org>
References: <20190824001041.11007-1-uwe@kleine-koenig.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190824001041.11007-1-uwe@kleine-koenig.org>
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

VGhpcyBkb2N1bWVudHMgdGhlIG15IGZpbmRpbmdzIHdoaWxlIHJlYWRpbmcgdGhyb3VnaCB0aGUg
ZHJpdmVyIGFuZCB0aGUKcmVmZXJlbmNlIG1hbnVhbC4KClNpZ25lZC1vZmYtYnk6IFV3ZSBLbGVp
bmUtS8O2bmlnIDx1d2VAa2xlaW5lLWtvZW5pZy5vcmc+Ci0tLQpDaGFuZ2VzIHNpbmNlIChpbXBs
aWNpdCkgdjEgc2VudCB3aXRoIE1lc3NhZ2UtSWQ6CjIwMTkwODE2MDkzNzQ4LjExNzY5LTEtdXdl
QGtsZWluZS1rb2VuaWcub3JnOgoKIC0gQWRkIHNvbWUgcHJvc2EgdG8gY29tbWl0IGxvZwoKIGRy
aXZlcnMvcHdtL3B3bS1hdG1lbC5jIHwgMTAgKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYyBiL2Ry
aXZlcnMvcHdtL3B3bS1hdG1lbC5jCmluZGV4IDM3ODZhYjlkYjVjZi4uODlmM2E2MmY3NTQxIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3B3bS9wd20tYXRtZWwuYworKysgYi9kcml2ZXJzL3B3bS9wd20t
YXRtZWwuYwpAQCAtNyw2ICs3LDE2IEBACiAgKgogICogTGlua3MgdG8gcmVmZXJlbmNlIG1hbnVh
bHMgZm9yIHRoZSBzdXBwb3J0ZWQgUFdNIGNoaXBzIGNhbiBiZSBmb3VuZCBpbgogICogRG9jdW1l
bnRhdGlvbi9hcm0vbWljcm9jaGlwLnJzdC4KKyAqCisgKiBMaW1pdGF0aW9uczoKKyAqIC0gUGVy
aW9kcyBzdGFydCB3aXRoIHRoZSBpbmFjdGl2ZSBsZXZlbC4KKyAqIC0gSGFyZHdhcmUgaGFzIHRv
IGJlIHN0b3BwZWQgaW4gZ2VuZXJhbCB0byB1cGRhdGUgc2V0dGluZ3MuCisgKgorICogU29mdHdh
cmUgYnVncy9wb3NzaWJsZSBpbXByb3ZlbWVudHM6CisgKiAtIFdoZW4gYXRtZWxfcHdtX2FwcGx5
KCkgaXMgY2FsbGVkIHdpdGggc3RhdGUtPmVuYWJsZWQ9ZmFsc2UgYSBjaGFuZ2UgaW4KKyAqICAg
c3RhdGUtPnBvbGFyaXR5IGlzbid0IGhvbm9yZWQuCisgKiAtIEluc3RlYWQgb2Ygc2xlZXBpbmcg
dG8gd2FpdCBmb3IgYSBjb21wbGV0ZWQgcGVyaW9kLCB0aGUgaW50ZXJydXB0CisgKiAgIGZ1bmN0
aW9uYWxpdHkgY291bGQgYmUgdXNlZC4KICAqLwogCiAjaW5jbHVkZSA8bGludXgvY2xrLmg+Ci0t
IAoyLjIwLjEKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC1hcm0ta2VybmVsCg==
