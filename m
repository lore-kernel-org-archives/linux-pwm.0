From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 6/8] dt-bindings: watchdog: Add missing clocks requirement
 in Samsung SoC watchdog
Date: Wed, 18 Sep 2019 19:31:39 +0200
Message-ID: <20190918173141.4314-6-krzk@kernel.org>
References: <20190918173141.4314-1-krzk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190918173141.4314-1-krzk@kernel.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Thierry Reding <thierry.reding@gmail.com>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Wim Van Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pwm@vger.kernel.org, linux-tegra@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-riscv@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-crypto@vger.kernel.org, linux-watchdog@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
List-Id: linux-pwm@vger.kernel.org

VGhlIFNhbXN1bmcgU29DIHdhdGNoZG9nIGRyaXZlciBhbHdheXMgcmVxdWlyZWQgcHJvdmlkaW5n
IGEgY2xvY2sKKGVpdGhlciB0aHJvdWdoIHBsYXRmb3JtIGRhdGEgb3IgZnJvbSBEVCkuICBIb3dl
dmVyIHdoZW4gYmluZGluZ3Mgd2VyZQphZGRlZCBpbiBjb21taXQgOTQ4N2E5Y2M3MTQwICgid2F0
Y2hkb2c6IHMzYzI0MTA6IEFkZCBzdXBwb3J0IGZvciBkZXZpY2UKdHJlZSBiYXNlZCBwcm9iZSIp
LCB0aGV5IG1pc3NlZCB0aGUgcmVxdWlyZW1lbnQgb2YgY2xvY2suCgpTaWduZWQtb2ZmLWJ5OiBL
cnp5c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+ClJldmlld2VkLWJ5OiBSb2IgSGVy
cmluZyA8cm9iaEBrZXJuZWwub3JnPgoKLS0tCgpDaGFuZ2VzIHNpbmNlIHYxOgoxLiBJbmRlbnQg
ZXhhbXBsZSB3aXRoIGZvdXIgc3BhY2VzIChtb3JlIHJlYWRhYmxlKSwKMi4gQWRkIGFsc28gbWlz
c2luZyByZXF1aXJlZCBlbnRyaWVzIGZvciBjbG9ja3MuCi0tLQogLi4uL2RldmljZXRyZWUvYmlu
ZGluZ3Mvd2F0Y2hkb2cvc2Ftc3VuZy13ZHQueWFtbCAgICAgICAgfCA5ICsrKysrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9zYW1zdW5nLXdkdC55YW1sIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3dhdGNoZG9nL3NhbXN1bmctd2R0LnlhbWwKaW5kZXgg
M2VhM2M5ZmU4MzkwLi4zMTFmOWRjODNmZGIgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9zYW1zdW5nLXdkdC55YW1sCisrKyBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy93YXRjaGRvZy9zYW1zdW5nLXdkdC55YW1sCkBAIC0y
Niw2ICsyNiwxMyBAQCBwcm9wZXJ0aWVzOgogICByZWc6CiAgICAgbWF4SXRlbXM6IDEKIAorICBj
bG9ja3M6CisgICAgbWF4SXRlbXM6IDEKKworICBjbG9jay1uYW1lczoKKyAgICBpdGVtczoKKyAg
ICAgIC0gY29uc3Q6IHdhdGNoZG9nCisKICAgaW50ZXJydXB0czoKICAgICBtYXhJdGVtczogMQog
CkBAIC00MCw2ICs0Nyw4IEBAIHByb3BlcnRpZXM6CiAKIHJlcXVpcmVkOgogICAtIGNvbXBhdGli
bGUKKyAgLSBjbG9ja3MKKyAgLSBjbG9jay1uYW1lcwogICAtIGludGVycnVwdHMKICAgLSByZWcK
IAotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9kcmktZGV2
ZWw=
