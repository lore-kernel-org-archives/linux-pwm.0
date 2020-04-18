From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.6 44/73] pwm: bcm2835: Dynamically allocate base
Date: Sat, 18 Apr 2020 09:47:46 -0400
Message-ID: <20200418134815.6519-44-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, linux-pwm@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Thierry Reding <thierry.reding@gmail.com>, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Nicolas Saenz Julienne <nsaenzjulienne@suse.de>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

RnJvbTogRmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+CgpbIFVwc3RyZWFt
IGNvbW1pdCAyYzI1YjA3ZTVlYzExOWNhYjYwOWU0MTQwN2ExZmIzZmE2MTQ0MmY1IF0KClRoZSBu
ZXdlciAyNzExIGFuZCA3MjExIGNoaXBzIGhhdmUgdHdvIFBXTSBjb250cm9sbGVycyBhbmQgZmFp
bHVyZSB0bwpkeW5hbWljYWxseSBhbGxvY2F0ZSB0aGUgUFdNIGJhc2Ugd291bGQgcHJldmVudCB0
aGUgc2Vjb25kIFBXTQpjb250cm9sbGVyIGluc3RhbmNlIGJlaW5nIHByb2JlZCBmb3Igc3VjY2Vl
ZGluZyB3aXRoIGFuIC1FRVhJU1QgZXJyb3IKZnJvbSBhbGxvY19wd21zKCkuCgpGaXhlczogZTVh
MDZkYzVhYzFmICgicHdtOiBBZGQgQkNNMjgzNSBQV00gZHJpdmVyIikKU2lnbmVkLW9mZi1ieTog
RmxvcmlhbiBGYWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+CkFja2VkLWJ5OiBVd2UgS2xl
aW5lLUvDtm5pZyA8dS5rbGVpbmUta29lbmlnQHBlbmd1dHJvbml4LmRlPgpSZXZpZXdlZC1ieTog
Tmljb2xhcyBTYWVueiBKdWxpZW5uZSA8bnNhZW56anVsaWVubmVAc3VzZS5kZT4KU2lnbmVkLW9m
Zi1ieTogVGhpZXJyeSBSZWRpbmcgPHRoaWVycnkucmVkaW5nQGdtYWlsLmNvbT4KU2lnbmVkLW9m
Zi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3JnPgotLS0KIGRyaXZlcnMvcHdtL3B3
bS1iY20yODM1LmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1iY20yODM1LmMgYi9kcml2ZXJzL3B3bS9wd20tYmNtMjgz
NS5jCmluZGV4IDkxZTI0ZjAxYjU0ZWQuLmQ3OGY4NmY4ZTQ2MjEgMTAwNjQ0Ci0tLSBhL2RyaXZl
cnMvcHdtL3B3bS1iY20yODM1LmMKKysrIGIvZHJpdmVycy9wd20vcHdtLWJjbTI4MzUuYwpAQCAt
MTY2LDYgKzE2Niw3IEBAIHN0YXRpYyBpbnQgYmNtMjgzNV9wd21fcHJvYmUoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldikKIAogCXBjLT5jaGlwLmRldiA9ICZwZGV2LT5kZXY7CiAJcGMtPmNo
aXAub3BzID0gJmJjbTI4MzVfcHdtX29wczsKKwlwYy0+Y2hpcC5iYXNlID0gLTE7CiAJcGMtPmNo
aXAubnB3bSA9IDI7CiAJcGMtPmNoaXAub2ZfeGxhdGUgPSBvZl9wd21feGxhdGVfd2l0aF9mbGFn
czsKIAlwYy0+Y2hpcC5vZl9wd21fbl9jZWxscyA9IDM7Ci0tIAoyLjIwLjEKCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1h
aWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==
