From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 07/12] backlight: register dependency parser for firmware
 nodes
Date: Wed,  1 Jul 2015 11:41:02 +0200
Message-ID: <1435743667-11987-8-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
List-Id: linux-pwm@vger.kernel.org

U28gb3RoZXJzIGNhbiBmaW5kIG91dCB3aGF0IGRlcGVuZHMgb24gYmFja2xpZ2h0IGRldmljZXMs
IGFzIHNwZWNpZmllZAppbiBiaW5kaW5ncy92aWRlby9iYWNrbGlnaHQvYmFja2xpZ2h0LnR4dC4K
ClNpZ25lZC1vZmYtYnk6IFRvbWV1IFZpem9zbyA8dG9tZXUudml6b3NvQGNvbGxhYm9yYS5jb20+
Ci0tLQoKQ2hhbmdlcyBpbiB2MjogTm9uZQoKIGRyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2JhY2ts
aWdodC5jIHwgMTYgKysrKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlv
bnMoKykKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9iYWNrbGlnaHQuYyBi
L2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2JhY2tsaWdodC5jCmluZGV4IGJkZGM4YjEuLmFiOGY1
ZTcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2JhY2tsaWdodC5jCisrKyBi
L2RyaXZlcnMvdmlkZW8vYmFja2xpZ2h0L2JhY2tsaWdodC5jCkBAIC01NjYsOCArNTY2LDIyIEBA
IHN0cnVjdCBiYWNrbGlnaHRfZGV2aWNlICpvZl9maW5kX2JhY2tsaWdodF9ieV9ub2RlKHN0cnVj
dCBkZXZpY2Vfbm9kZSAqbm9kZSkKIEVYUE9SVF9TWU1CT0wob2ZfZmluZF9iYWNrbGlnaHRfYnlf
bm9kZSk7CiAjZW5kaWYKIAorc3RhdGljIHZvaWQgYmFja2xpZ2h0X2dldF9kZXBlbmRlbmNpZXMo
c3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSwKKwkJCQkJICBzdHJ1Y3QgbGlzdF9oZWFkICpk
ZXBzKQoreworCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbnA7CisKKwlucCA9IG9mX3BhcnNlX3BoYW5k
bGUodG9fb2Zfbm9kZShmd25vZGUpLCAiYmFja2xpZ2h0IiwgMCk7CisJaWYgKCFucCkKKwkJcmV0
dXJuOworCisJZndub2RlX2FkZF9kZXBlbmRlbmN5KCZucC0+Zndub2RlLCBkZXBzKTsKK30KKwog
c3RhdGljIHZvaWQgX19leGl0IGJhY2tsaWdodF9jbGFzc19leGl0KHZvaWQpCiB7CisJZndub2Rl
X3JlbW92ZV9kZXBlbmRlbmN5X3BhcnNlcihiYWNrbGlnaHRfZ2V0X2RlcGVuZGVuY2llcyk7CisK
IAljbGFzc19kZXN0cm95KGJhY2tsaWdodF9jbGFzcyk7CiB9CiAKQEAgLTU4Niw2ICs2MDAsOCBA
QCBzdGF0aWMgaW50IF9faW5pdCBiYWNrbGlnaHRfY2xhc3NfaW5pdCh2b2lkKQogCW11dGV4X2lu
aXQoJmJhY2tsaWdodF9kZXZfbGlzdF9tdXRleCk7CiAJQkxPQ0tJTkdfSU5JVF9OT1RJRklFUl9I
RUFEKCZiYWNrbGlnaHRfbm90aWZpZXIpOwogCisJZndub2RlX2FkZF9kZXBlbmRlbmN5X3BhcnNl
cihiYWNrbGlnaHRfZ2V0X2RlcGVuZGVuY2llcyk7CisKIAlyZXR1cm4gMDsKIH0KIAotLSAKMi40
LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1k
ZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwOi8v
bGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxtYW4vbGlzdGluZm8vZHJpLWRldmVsCg==
