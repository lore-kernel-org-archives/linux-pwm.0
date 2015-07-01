From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 10/12] pwm: register dependency parser for firmware nodes
Date: Wed,  1 Jul 2015 11:41:05 +0200
Message-ID: <1435743667-11987-11-git-send-email-tomeu.vizoso@collabora.com>
References: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <1435743667-11987-1-git-send-email-tomeu.vizoso@collabora.com>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

U28gb3RoZXJzIGNhbiBmaW5kIG91dCB3aGF0IGRlcGVuZHMgb24gcHdtIGNvbnRyb2xsZXJzLCBh
cyBzcGVjaWZpZWQKaW4gYmluZGluZ3MvcHdtL3B3bS50eHQuCgpTaWduZWQtb2ZmLWJ5OiBUb21l
dSBWaXpvc28gPHRvbWV1LnZpem9zb0Bjb2xsYWJvcmEuY29tPgotLS0KCkNoYW5nZXMgaW4gdjI6
IE5vbmUKCiBkcml2ZXJzL3B3bS9jb3JlLmMgfCAyOCArKysrKysrKysrKysrKysrKysrKysrKysr
KysrCiAxIGZpbGUgY2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcHdtL2NvcmUuYyBiL2RyaXZlcnMvcHdtL2NvcmUuYwppbmRleCAzYTc3NjlmLi44MWI0ZmMw
IDEwMDY0NAotLS0gYS9kcml2ZXJzL3B3bS9jb3JlLmMKKysrIGIvZHJpdmVycy9wd20vY29yZS5j
CkBAIC05MTcsMTEgKzkxNywzOSBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGZpbGVfb3BlcmF0aW9u
cyBwd21fZGVidWdmc19vcHMgPSB7CiAJLnJlbGVhc2UgPSBzZXFfcmVsZWFzZSwKIH07CiAKK3N0
YXRpYyB2b2lkIHB3bV9nZXRfZGVwZW5kZW5jaWVzKHN0cnVjdCBmd25vZGVfaGFuZGxlICpmd25v
ZGUsCisJCQkJIHN0cnVjdCBsaXN0X2hlYWQgKmRlcHMpCit7CisJc3RydWN0IGRldmljZV9ub2Rl
ICpucDsKKwlzdHJ1Y3Qgb2ZfcGhhbmRsZV9hcmdzIHBzcGVjOworCWludCBjb3VudCwgaSwgcmV0
OworCisJbnAgPSB0b19vZl9ub2RlKGZ3bm9kZSk7CisJaWYgKCFucCkKKwkJcmV0dXJuOworCisJ
Y291bnQgPSBvZl9jb3VudF9waGFuZGxlX3dpdGhfYXJncyhucCwgInB3bXMiLAorCQkJCQkgICAi
I3B3bS1jZWxscyIpOworCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7CisJCXJldCA9IG9m
X3BhcnNlX3BoYW5kbGVfd2l0aF9hcmdzKG5wLCAicHdtcyIsCisJCQkJCQkgIiNwd20tY2VsbHMi
LCBpLAorCQkJCQkJICZwc3BlYyk7CisJCWlmIChyZXQgfHwgIXBzcGVjLm5wKQorCQkJY29udGlu
dWU7CisKKwkJZndub2RlX2FkZF9kZXBlbmRlbmN5KCZwc3BlYy5ucC0+Zndub2RlLCBkZXBzKTsK
KworCQlvZl9ub2RlX3B1dChwc3BlYy5ucCk7CisJfQorfQorCiBzdGF0aWMgaW50IF9faW5pdCBw
d21fZGVidWdmc19pbml0KHZvaWQpCiB7CiAJZGVidWdmc19jcmVhdGVfZmlsZSgicHdtIiwgU19J
RlJFRyB8IFNfSVJVR08sIE5VTEwsIE5VTEwsCiAJCQkgICAgJnB3bV9kZWJ1Z2ZzX29wcyk7CiAK
Kwlmd25vZGVfYWRkX2RlcGVuZGVuY3lfcGFyc2VyKHB3bV9nZXRfZGVwZW5kZW5jaWVzKTsKKwog
CXJldHVybiAwOwogfQogCi0tIAoyLjQuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
