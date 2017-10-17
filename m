From: Jeffy Chen <jeffy.chen@rock-chips.com>
Subject: [RFC PATCH v3 0/5] rockchip: kevin: Enable edp display
Date: Tue, 17 Oct 2017 16:09:20 +0800
Message-ID: <20171017080925.23763-1-jeffy.chen@rock-chips.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, rjw@rjwysocki.net, Will Deacon <will.deacon@arm.com>, dri-devel@lists.freedesktop.org, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-samsung-soc@vger.kernel.org, briannorris@chromium.org, Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org, Matthias Kaehlcke <mka@chromium.org>, Catalin Marinas <catalin.marinas@arm.com>, Caesar Wang <wxt@rock-chips.com>, linux-pwm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jeffy Chen <jeffy.chen@rock-chips.com>, broonie@kernel.org, linux-arm-kernel@lists.infradead.org, zain wang <wzz@rock-chips.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Jingoo Han <jingoohan1@gmail.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dmitry.torokhov@gmail.com, Seung
List-Id: linux-pwm@vger.kernel.org

Ck1ha2UgZWRwIGRpc3BsYXkgd29ya3Mgb24gY2hyb21lYm9vayBrZXZpbihhdCBsZWFzdCBmb3Ig
Ym9vdCBhbmltYXRpb24pLgoKQWxzbyBzb2x2ZSBzb21lIGlzc3VlcyBpIG1lZXQgZHVyaW5nIHRo
ZSBicmluZ3VwLgoKQ2hhbmdlcyBpbiB2MzoKQXNzaWduIG9ycGhhbiBwd21zIHRvIGR1bW15IHB3
bWNoaXAgaW5zdGVhZCBvZiBhZGRpbmcgZGV2aWNlIGxpbmsgaW4gdGhlCmN1c3RvbWVyIGRyaXZl
ci4KCkNoYW5nZXMgaW4gdjI6ClVzZSBkZXZpY2UgbGluayB0byBjb3JyZWN0IHRoZSBzdXNwZW5k
L3Jlc3VtZSBhbmQgc2h1dGRvd24gb3JkZXJpbmcsCmluc3RlYWQgb2YgY29udmVydGluZyByb2Nr
Y2hpcCBzcGkncyBzdXNwZW5kL3Jlc3VtZSBQTSBjYWxsYmFja3MgdG8KbGF0ZSBzdXNwZW5kL3Jl
c3VtZSBQTSBjYWxsYmFja3MuCgpKZWZmeSBDaGVuICg0KToKICBhcm02NDogZHRzOiByb2NrY2hp
cDogRW5hYmxlIGVkcCBkaXNhcGxheSBvbiBrZXZpbgogIGRybS9yb2NrY2hpcDogRml4IGVycm9y
IGhhbmRsaW5nIHBhdGggaW4gcm9ja2NoaXBfZHBfYmluZCgpCiAgcHdtOiBBZGQgZHVtbXkgcHdt
Y2hpcCBmb3Igb3JwaGFuIHB3bXMKICBkcm0vcm9ja2NoaXA6IEFkZCBkZXZpY2UgbGlua3MgZm9y
IG1hc3RlciBhbmQgY29tcG9uZW50cwoKVG9tYXN6IEZpZ2EgKDEpOgogIGRybS9icmlkZ2UvYW5h
bG9naXg6IERvIG5vdCB1c2UgZGV2aWNlJ3MgZHJ2ZGF0YQoKIGFyY2gvYXJtNjQvYm9vdC9kdHMv
cm9ja2NoaXAvcmszMzk5LWdydS1rZXZpbi5kdHMgIHwgMjkgKysrKysrKysKIGFyY2gvYXJtNjQv
Ym9vdC9kdHMvcm9ja2NoaXAvcmszMzk5LWdydS5kdHNpICAgICAgIHwgMTYgKysrKysKIGRyaXZl
cnMvZ3B1L2RybS9icmlkZ2UvYW5hbG9naXgvYW5hbG9naXhfZHBfY29yZS5jIHwgNTAgKysrKysr
LS0tLS0tLQogZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHAuYyAgICAgICAgICAgICAg
ICAgfCAyNiArKysrLS0tCiBkcml2ZXJzL2dwdS9kcm0vcm9ja2NoaXAvYW5hbG9naXhfZHAtcm9j
a2NoaXAuYyAgICB8IDU3ICsrKysrKysrKy0tLS0tLQogZHJpdmVycy9ncHUvZHJtL3JvY2tjaGlw
L3JvY2tjaGlwX2RybV9kcnYuYyAgICAgICAgfCAyNCArKysrKystCiBkcml2ZXJzL3B3bS9jb3Jl
LmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDg0ICsrKysrKysrKysrKysrKysr
KysrLS0KIGluY2x1ZGUvZHJtL2JyaWRnZS9hbmFsb2dpeF9kcC5oICAgICAgICAgICAgICAgICAg
IHwgMTkgKystLS0KIDggZmlsZXMgY2hhbmdlZCwgMjI2IGluc2VydGlvbnMoKyksIDc5IGRlbGV0
aW9ucygtKQoKLS0gCjIuMTEuMAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2RyaS1kZXZlbAo=
