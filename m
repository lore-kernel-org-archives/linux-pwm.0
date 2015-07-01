From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: [PATCH v2 06/12] backlight: Document consumers of backlight nodes
Date: Wed,  1 Jul 2015 11:41:01 +0200
Message-ID: <1435743667-11987-7-git-send-email-tomeu.vizoso@collabora.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, linux-gpio@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, alsa-devel@alsa-project.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-pwm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>
List-Id: linux-pwm@vger.kernel.org

QWRkIGEgc21hbGwgbm90ZSB0aGF0IG1ha2VzIGV4cGxpY2l0IHRoYXQgcHJvcGVydGllcyBuYW1l
ZCAnYmFja2xpZ2h0Jwpjb250YWluIHBoYW5kbGVzIHRvIGJhY2tsaWdodCBub2Rlcy4KClRoaXMg
aXMgbmVlZGVkIHNvIHRoYXQgd2UgY2FuIGF1dG9tYXRpY2FsbHkgZXh0cmFjdCBkZXBlbmRlbmNp
ZXMgb24KYmFja2xpZ2h0IGRldmljZXMgYnkgYXNzdW1pbmcgdGhhdCBhIHByb3BlcnR5IHdpdGgg
dGhhdCBuYW1lIGNvbnRhaW5zIGEKcGhhbmRsZSB0byBzdWNoIGEgZGV2aWNlLgoKU2lnbmVkLW9m
Zi1ieTogVG9tZXUgVml6b3NvIDx0b21ldS52aXpvc29AY29sbGFib3JhLmNvbT4KLS0tCgpDaGFu
Z2VzIGluIHYyOgotIERvY3VtZW50IHRoYXQgY29uc3VtZXJzIG9mIGJhY2tsaWdodCBkZXZpY2Vz
IGNhbiB1c2UgdGhlICdiYWNrbGlnaHQnCiAgcHJvcGVydHkgdG8gaG9sZCBhIHBoYW5kbGUgdG8g
dGhlIGJhY2tsaWdodCBkZXZpY2UuCgogLi4uL2JpbmRpbmdzL3ZpZGVvL2JhY2tsaWdodC9iYWNr
bGlnaHQudHh0ICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy92aWRlby9iYWNrbGlnaHQvYmFja2xpZ2h0LnR4dAoKZGlmZiAt
LWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92aWRlby9iYWNrbGlnaHQv
YmFja2xpZ2h0LnR4dCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy92aWRlby9i
YWNrbGlnaHQvYmFja2xpZ2h0LnR4dApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
Li4zMDk5NDlkCi0tLSAvZGV2L251bGwKKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3ZpZGVvL2JhY2tsaWdodC9iYWNrbGlnaHQudHh0CkBAIC0wLDAgKzEsMjIgQEAKK1Nw
ZWNpZnlpbmcgYmFja2xpZ2h0IGluZm9ybWF0aW9uIGZvciBkZXZpY2VzCis9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQorCitCYWNrbGlnaHQgdXNlciBub2Rlcwor
LS0tLS0tLS0tLS0tLS0tLS0tLS0KKworTm9kZXMgc3VjaCBhcyBkaXNwbGF5IHBhbmVscyB0aGF0
IHJlZmVyIHRvIGJhY2tsaWdodCBkZXZpY2VzIGNhbiBkbyBzbyBieSBzaW1wbHkgaGF2aW5nIGEg
cHJvcGVydHkgbmFtZWQgJ2JhY2tsaWdodCcgdGhhdCBjb250YWlucyBhIHBoYW5kbGUgdG8gYSBi
YWNrbGlnaHQgbm9kZS4KKworRXhhbXBsZToKKworCWJhY2tsaWdodDogYmFja2xpZ2h0IHsKKwkJ
Y29tcGF0aWJsZSA9ICJncGlvLWJhY2tsaWdodCI7CisJCWdwaW9zID0gPCZncGlvMyA0IEdQSU9f
QUNUSVZFX0hJR0g+OworCX07CisKKwlbLi4uXQorCisJcGFuZWw6IHBhbmVsIHsKKwkJY29tcGF0
aWJsZSA9ICJjcHR0LGNsYWExMDF3YjAxIjsKKworCQliYWNrbGlnaHQgPSA8JmJhY2tsaWdodD47
CisJfTsKLS0gCjIuNC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3Rv
cC5vcmcKaHR0cDovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1k
ZXZlbAo=
