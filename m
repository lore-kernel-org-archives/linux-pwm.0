From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 09/12] regulator: register dependency parser for firmware
 nodes
Date: Wed,  1 Jul 2015 11:41:04 +0200
Message-ID: <1435743667-11987-10-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, Liam Girdwood <lgirdwood@gmail.com>, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org
List-Id: linux-pwm@vger.kernel.org

U28gb3RoZXJzIGNhbiBmaW5kIG91dCB3aGF0IGRlcGVuZHMgb24gcmVndWxhdG9ycywgYXMgc3Bl
Y2lmaWVkCmluIGJpbmRpbmdzL3JlZ3VsYXRvci9yZWd1bGF0b3IudHh0LgoKU2lnbmVkLW9mZi1i
eTogVG9tZXUgVml6b3NvIDx0b21ldS52aXpvc29AY29sbGFib3JhLmNvbT4KLS0tCgpDaGFuZ2Vz
IGluIHYyOiBOb25lCgogZHJpdmVycy9yZWd1bGF0b3IvY29yZS5jIHwgMjcgKysrKysrKysrKysr
KysrKysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQoKZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcmVndWxhdG9yL2NvcmUuYyBiL2RyaXZlcnMvcmVndWxhdG9yL2NvcmUu
YwppbmRleCBjOWY3MjAxLi41MzVjYWQwIDEwMDY0NAotLS0gYS9kcml2ZXJzL3JlZ3VsYXRvci9j
b3JlLmMKKysrIGIvZHJpdmVycy9yZWd1bGF0b3IvY29yZS5jCkBAIC00MTEyLDYgKzQxMTIsMzEg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmaWxlX29wZXJhdGlvbnMgcmVndWxhdG9yX3N1bW1hcnlf
Zm9wcyA9IHsKICNlbmRpZgogfTsKIAorc3RhdGljIHZvaWQgcmVndWxhdG9yX2dldF9kZXBlbmRl
bmNpZXMoc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSwKKwkJCQkgICAgICAgc3RydWN0IGxp
c3RfaGVhZCAqZGVwcykKK3sKKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKm5wOworCXN0cnVjdCBwcm9w
ZXJ0eSAqcHA7CisJc3RydWN0IGRldmljZV9ub2RlICpkZXA7CisKKwlucCA9IHRvX29mX25vZGUo
Zndub2RlKTsKKwlpZiAoIW5wKQorCQlyZXR1cm47CisKKwlmb3JfZWFjaF9wcm9wZXJ0eV9vZl9u
b2RlKG5wLCBwcCkgeworCQlpZiAoIXN0cmVuZHMocHAtPm5hbWUsICItc3VwcGx5IikpCisJCQlj
b250aW51ZTsKKworCQlkZXAgPSBvZl9wYXJzZV9waGFuZGxlKG5wLCBwcC0+bmFtZSwgMCk7CisJ
CWlmICghZGVwKQorCQkJY29udGludWU7CisKKwkJZndub2RlX2FkZF9kZXBlbmRlbmN5KCZkZXAt
PmZ3bm9kZSwgZGVwcyk7CisKKwkJb2Zfbm9kZV9wdXQoZGVwKTsKKwl9Cit9CisKIHN0YXRpYyBp
bnQgX19pbml0IHJlZ3VsYXRvcl9pbml0KHZvaWQpCiB7CiAJaW50IHJldDsKQEAgLTQxMzAsNiAr
NDE1NSw4IEBAIHN0YXRpYyBpbnQgX19pbml0IHJlZ3VsYXRvcl9pbml0KHZvaWQpCiAKIAlyZWd1
bGF0b3JfZHVtbXlfaW5pdCgpOwogCisJZndub2RlX2FkZF9kZXBlbmRlbmN5X3BhcnNlcihyZWd1
bGF0b3JfZ2V0X2RlcGVuZGVuY2llcyk7CisKIAlyZXR1cm4gcmV0OwogfQogCi0tIAoyLjQuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVs
IG1haWxpbmcgbGlzdApkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHA6Ly9saXN0
cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2ZWwK
