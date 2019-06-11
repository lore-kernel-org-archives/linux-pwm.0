From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v4 5/7] drm/mediatek: add mt8183 dsi driver support
Date: Tue, 11 Jun 2019 10:37:07 +0800
Message-ID: <1560220627.32395.1.camel@mtksdaap41>
References: <20190601092615.67917-1-jitao.shi@mediatek.com>
 <20190601092615.67917-6-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190601092615.67917-6-jitao.shi@mediatek.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jitao Shi <jitao.shi@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

SGksIEppdGFvOgoKT24gU2F0LCAyMDE5LTA2LTAxIGF0IDE3OjI2ICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6Cj4gQWRkIG10ODE4MyBkc2kgZHJpdmVyIGRhdGEuIEVuYWJsZSBzaXplIGNvbnRyb2wg
YW5kCj4gcmVnIGNvbW1pdCBjb250cm9sLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8
aml0YW8uc2hpQG1lZGlhdGVrLmNvbT4KPiBSZXZpZXdlZC1ieTogQ0sgSHUgPGNrLmh1QG1lZGlh
dGVrLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kc2kuYyB8IDgg
KysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jIGIvZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19kc2kuYwo+IGluZGV4IDE4YTE5MjY1NmE4OS4uYWJmNmRkZWM1ZGI2IDEw
MDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHNpLmMKPiArKysgYi9k
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RzaS5jCj4gQEAgLTEyMjUsMTEgKzEyMjUsMTkg
QEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHNpX2RyaXZlcl9kYXRhIG10MjcwMV9kc2lfZHJp
dmVyX2RhdGEgPSB7Cj4gIAkucmVnX2NtZHFfb2ZmID0gMHgxODAsCj4gIH07Cj4gIAo+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kc2lfZHJpdmVyX2RhdGEgbXQ4MTgzX2RzaV9kcml2ZXJfZGF0
YSA9IHsKPiArCS5yZWdfY21kcV9vZmYgPSAweDIwMCwKPiArCS5oYXNfc2hhZG93X2N0bCA9IHRy
dWUsCj4gKwkuaGFzX3NpemVfY3RsID0gdHJ1ZSwKPiArfTsKPiArCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kc2lfb2ZfbWF0Y2hbXSA9IHsKPiAgCXsgLmNvbXBhdGli
bGUgPSAibWVkaWF0ZWssbXQyNzAxLWRzaSIsCj4gIAkgIC5kYXRhID0gJm10MjcwMV9kc2lfZHJp
dmVyX2RhdGEgfSwKPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTczLWRzaSIsCj4g
IAkgIC5kYXRhID0gJm10ODE3M19kc2lfZHJpdmVyX2RhdGEgfSwKPiArCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTgzLWRzaSIsCgpJIGRvZXMgbm90IGZpbmQgIm1lZGlhdGVrLG10ODE4
My1kc2kiIGluIGJpbmRpbmcgZG9jdW1lbnQsIHNvIHBsZWFzZQpzZW5kIGEgcGF0Y2ggdG8gYWRk
IHRoaXMgaW4gYmluZGluZyBkb2N1bWVudC4KClJlZ2FyZHMsCkNLCgo+ICsJICAuZGF0YSA9ICZt
dDgxODNfZHNpX2RyaXZlcl9kYXRhIH0sCj4gIAl7IH0sCj4gIH07Cj4gIAoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
