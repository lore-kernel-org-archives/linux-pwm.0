From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [PATCH 0/5] rockchip: kevin: Enable edp display
Date: Mon, 16 Oct 2017 17:59:13 +0800
Message-ID: <20171016095918.25588-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Klaus Goger <klaus.goger@theobroma-systems.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Lee Jones <lee.jones@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Daniel Thompson <daniel.thompson@linaro.org>, linux-samsung-soc@vger.kernel.org, briannorris@chromium.org, Krzysztof Kozlowski <krzk@kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Caesar Wang <wxt@rock-chips.com>, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jef
List-Id: linux-pwm@vger.kernel.org

Ck1ha2UgZWRwIGRpc3BsYXkgd29ya3Mgb24gY2hyb21lYm9vayBrZXZpbihhdCBsZWFzdCBmb3Ig
Ym9vdCBhbmltYXRpb24pLgoKQWxzbyBzb2x2ZSBzb21lIGlzc3VlcyBpIG1lZXQgZHVyaW5nIHRo
ZSBicmluZ3VwLgoKCkplZmZ5IENoZW4gKDQpOgogIGFybTY0OiBkdHM6IHJvY2tjaGlwOiBFbmFi
bGUgZWRwIGRpc2FwbGF5IG9uIGtldmluCiAgYmFja2xpZ2h0OiBwd21fYmw6IEFkZCBkZXZpY2Ug
bGluayBmb3IgcHdtX2JsIGFuZCBwd20KICBkcm0vcm9ja2NoaXA6IEZpeCBlcnJvciBoYW5kbGlu
ZyBwYXRoIGluIHJvY2tjaGlwX2RwX2JpbmQoKQogIGRybS9yb2NrY2hpcDogQWRkIGRldmljZSBs
aW5rcyBmb3IgbWFzdGVyIGFuZCBjb21wb25lbnRzCgpUb21hc3ogRmlnYSAoMSk6CiAgZHJtL2Jy
aWRnZS9hbmFsb2dpeDogRG8gbm90IHVzZSBkZXZpY2UncyBkcnZkYXRhCgogYXJjaC9hcm02NC9i
b290L2R0cy9yb2NrY2hpcC9yazMzOTktZ3J1LWtldmluLmR0cyAgfCAyOSArKysrKysrKysrKwog
YXJjaC9hcm02NC9ib290L2R0cy9yb2NrY2hpcC9yazMzOTktZ3J1LmR0c2kgICAgICAgfCAxNiAr
KysrKysKIGRyaXZlcnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9naXhfZHBfY29yZS5j
IHwgNTAgKysrKysrKystLS0tLS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3Nf
ZHAuYyAgICAgICAgICAgICAgICAgfCAyNiArKysrKy0tLS0tCiBkcml2ZXJzL2dwdS9kcm0vcm9j
a2NoaXAvYW5hbG9naXhfZHAtcm9ja2NoaXAuYyAgICB8IDU3ICsrKysrKysrKysrKysrLS0tLS0t
LS0KIGRyaXZlcnMvZ3B1L2RybS9yb2NrY2hpcC9yb2NrY2hpcF9kcm1fZHJ2LmMgICAgICAgIHwg
MjQgKysrKysrKy0tCiBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21fYmwuYyAgICAgICAgICAg
ICAgICAgICB8ICAyICsKIGluY2x1ZGUvZHJtL2JyaWRnZS9hbmFsb2dpeF9kcC5oICAgICAgICAg
ICAgICAgICAgIHwgMTkgKysrKystLS0KIDggZmlsZXMgY2hhbmdlZCwgMTUxIGluc2VydGlvbnMo
KyksIDcyIGRlbGV0aW9ucygtKQoKLS0gCjIuMTEuMAoKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2RyaS1kZXZlbAo=
