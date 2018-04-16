From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] backlight: pwm_bl: don't use GPIOF_* with
 gpiod_get_direction
Date: Mon, 16 Apr 2018 10:11:06 +0100
Message-ID: <20180416091106.lg7nesbqvfeehuzq@dell>
References: <20180114210711.13863-1-wsa+renesas@sang-engineering.com>
 <20180114210711.13863-4-wsa+renesas@sang-engineering.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20180114210711.13863-4-wsa+renesas@sang-engineering.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: linux-pwm@vger.kernel.org, Daniel Thompson <daniel.thompson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>
List-Id: linux-pwm@vger.kernel.org

T24gU3VuLCAxNCBKYW4gMjAxOCwgV29sZnJhbSBTYW5nIHdyb3RlOgoKPiBUaGUgZG9jdW1lbnRh
dGlvbiB3YXMgd3JvbmcsIGdwaW9kX2dldF9kaXJlY3Rpb24oKSByZXR1cm5zIDAvMSBpbnN0ZWFk
Cj4gb2YgdGhlIEdQSU9GXyogZmxhZ3MuIFRoZSBkb2NzIHdlcmUgZml4ZWQgd2l0aCBjb21taXQg
OTRmYzczMDk0YWJlNDcKPiAoImdwaW86IGNvcnJlY3QgZG9jcyBhYm91dCByZXR1cm4gdmFsdWUg
b2YgZ3Bpb2RfZ2V0X2RpcmVjdGlvbiIpLiBOb3csCj4gZml4IHRoaXMgdXNlciAodW50aWwgYSBi
ZXR0ZXIsIHN5c3RlbS13aWRlIHNvbHV0aW9uIGlzIGluIHBsYWNlKS4KPiAKPiBTaWduZWQtb2Zm
LWJ5OiBXb2xmcmFtIFNhbmcgPHdzYStyZW5lc2FzQHNhbmctZW5naW5lZXJpbmcuY29tPgo+IC0t
LQo+IE9ubHkgYnVpbGQgdGVzdGVkIQo+IAo+ICBkcml2ZXJzL3ZpZGVvL2JhY2tsaWdodC9wd21f
YmwuYyB8IDYgKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKyksIDMgZGVs
ZXRpb25zKC0pCgpBcHBsaWVkIHdpdGggRGFuaWVsIGFuZCBTaW1vbidzIEFja3MuCgotLSAKTGVl
IEpvbmVzIFvmnY7nkLzmlq9dCkxpbmFybyBTZXJ2aWNlcyBUZWNobmljYWwgTGVhZApMaW5hcm8u
b3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKRm9sbG93IExpbmFybzog
RmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpkcmktZGV2ZWwgbWFpbGluZyBsaXN0CmRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0
aW5mby9kcmktZGV2ZWwK
