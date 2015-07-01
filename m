From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 03/12] string: Introduce strends()
Date: Wed,  1 Jul 2015 11:40:58 +0200
Message-ID: <1435743667-11987-4-git-send-email-tomeu.vizoso@collabora.com>
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

VG8gYXZvaWQgZHVwbGljYXRpbmcgY29kZSBpbiB1cGNvbWluZyBwYXRjaGVzIHRoYXQgd2lsbCBj
aGVjayBmb3IKcG9zdGZpeGVzIGluIHN0cmluZ3MsIGFkZCBzdHJlbmRzKCkuCgpTaWduZWQtb2Zm
LWJ5OiBUb21ldSBWaXpvc28gPHRvbWV1LnZpem9zb0Bjb2xsYWJvcmEuY29tPgotLS0KCkNoYW5n
ZXMgaW4gdjI6Ci0gTW92ZSBzdHJlbmRzIHRvIHN0cmluZy5oCgogaW5jbHVkZS9saW51eC9zdHJp
bmcuaCB8IDEzICsrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCsp
CgpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9zdHJpbmcuaCBiL2luY2x1ZGUvbGludXgvc3Ry
aW5nLmgKaW5kZXggZDVkZmUzZS4uNDI0NDM2MyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9z
dHJpbmcuaAorKysgYi9pbmNsdWRlL2xpbnV4L3N0cmluZy5oCkBAIC0xNDYsNiArMTQ2LDE5IEBA
IHN0YXRpYyBpbmxpbmUgYm9vbCBzdHJzdGFydHMoY29uc3QgY2hhciAqc3RyLCBjb25zdCBjaGFy
ICpwcmVmaXgpCiAJcmV0dXJuIHN0cm5jbXAoc3RyLCBwcmVmaXgsIHN0cmxlbihwcmVmaXgpKSA9
PSAwOwogfQogCisvKioKKyAqIHN0cmVuZHMgLSBkb2VzIEBzdHIgZW5kIHdpdGggQHBvc3RmaXg/
CisgKiBAc3RyOiBzdHJpbmcgdG8gZXhhbWluZQorICogQHBvc3RmaXg6IHBvc3RmaXggdG8gbG9v
ayBmb3IKKyAqLworc3RhdGljIGlubGluZSBib29sIHN0cmVuZHMoY29uc3QgY2hhciAqc3RyLCBj
b25zdCBjaGFyICpwb3N0Zml4KQoreworCWlmIChzdHJsZW4oc3RyKSA8IHN0cmxlbihwb3N0Zml4
KSkKKwkJcmV0dXJuIGZhbHNlOworCisJcmV0dXJuIHN0cmNtcChzdHIgKyBzdHJsZW4oc3RyKSAt
IHN0cmxlbihwb3N0Zml4KSwgcG9zdGZpeCkgPT0gMDsKK30KKwogc2l6ZV90IG1lbXdlaWdodChj
b25zdCB2b2lkICpwdHIsIHNpemVfdCBieXRlcyk7CiB2b2lkIG1lbXplcm9fZXhwbGljaXQodm9p
ZCAqcywgc2l6ZV90IGNvdW50KTsKIAotLSAKMi40LjEKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVsCg==
