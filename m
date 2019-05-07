From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v3 2/3] drm/mediatek: dpi dual edge support
Date: Tue, 7 May 2019 15:35:28 +0800
Message-ID: <1557214528.3498.3.camel@mtksdaap41>
References: <20190416055242.75764-1-jitao.shi@mediatek.com>
 <20190416055242.75764-3-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190416055242.75764-3-jitao.shi@mediatek.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Sean Paul <seanpaul@chromium>
List-Id: linux-pwm@vger.kernel.org

SGksIEppdGFvOgoKT24gVHVlLCAyMDE5LTA0LTE2IGF0IDEzOjUyICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6CgpXaGVyZSBpcyB0aGUgY29tbWl0IG1lc3NhZ2U/IEkgdGhpbmsgeW91IGNvdWxkIGlu
dHJvZHVjZSB3aGF0IGlzIGR1YWwKZWRnZSAoTWF5YmUgaXQncyB0cml2aWFsIGZvciB5b3UsIGJ1
dCBub3QgZm9yIG1lKQoKUmVnYXJkcywKQ0sKCj4gU2lnbmVkLW9mZi1ieTogSml0YW8gU2hpIDxq
aXRhby5zaGlAbWVkaWF0ZWsuY29tPgo+IC0tLQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwaS5jIHwgMTAgKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9u
cygrKQo+IAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5j
IGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYwo+IGluZGV4IDIyZTY4YTEwMGU3
Yi4uNjY0MDUxNTkxNDFhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9t
dGtfZHBpLmMKPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX2RwaS5jCj4gQEAg
LTExNyw2ICsxMTcsNyBAQCBzdHJ1Y3QgbXRrX2RwaV9jb25mIHsKPiAgCXVuc2lnbmVkIGludCAo
KmNhbF9mYWN0b3IpKGludCBjbG9jayk7Cj4gIAl1MzIgcmVnX2hfZnJlX2NvbjsKPiAgCWJvb2wg
ZWRnZV9zZWxfZW47Cj4gKwlib29sIGR1YWxfZWRnZTsKPiAgfTsKPiAgCj4gIHN0YXRpYyB2b2lk
IG10a19kcGlfbWFzayhzdHJ1Y3QgbXRrX2RwaSAqZHBpLCB1MzIgb2Zmc2V0LCB1MzIgdmFsLCB1
MzIgbWFzaykKPiBAQCAtMzUzLDYgKzM1NCwxMyBAQCBzdGF0aWMgdm9pZCBtdGtfZHBpX2NvbmZp
Z19kaXNhYmxlX2VkZ2Uoc3RydWN0IG10a19kcGkgKmRwaSkKPiAgCQltdGtfZHBpX21hc2soZHBp
LCBkcGktPmNvbmYtPnJlZ19oX2ZyZV9jb24sIDAsIEVER0VfU0VMX0VOKTsKPiAgfQo+ICAKPiAr
c3RhdGljIHZvaWQgbXRrX2RwaV9lbmFibGVfZHVhbF9lZGdlKHN0cnVjdCBtdGtfZHBpICpkcGkp
Cj4gK3sKPiArCW10a19kcGlfbWFzayhkcGksIERQSV9ERFJfU0VUVElORywgRERSX0VOIHwgRERS
XzRQSEFTRSwKPiArCQkgICAgIEREUl9FTiB8IEREUl80UEhBU0UpOwo+ICsJbXRrX2RwaV9tYXNr
KGRwaSwgRFBJX09VVFBVVF9TRVRUSU5HLCBFREdFX1NFTCwgRURHRV9TRUwpOwo+ICt9Cj4gKwo+
ICBzdGF0aWMgdm9pZCBtdGtfZHBpX2NvbmZpZ19jb2xvcl9mb3JtYXQoc3RydWN0IG10a19kcGkg
KmRwaSwKPiAgCQkJCQllbnVtIG10a19kcGlfb3V0X2NvbG9yX2Zvcm1hdCBmb3JtYXQpCj4gIHsK
PiBAQCAtNTA5LDYgKzUxNyw4IEBAIHN0YXRpYyBpbnQgbXRrX2RwaV9zZXRfZGlzcGxheV9tb2Rl
KHN0cnVjdCBtdGtfZHBpICpkcGksCj4gIAltdGtfZHBpX2NvbmZpZ19jb2xvcl9mb3JtYXQoZHBp
LCBkcGktPmNvbG9yX2Zvcm1hdCk7Cj4gIAltdGtfZHBpX2NvbmZpZ18ybl9oX2ZyZShkcGkpOwo+
ICAJbXRrX2RwaV9jb25maWdfZGlzYWJsZV9lZGdlKGRwaSk7Cj4gKwlpZiAoZHBpLT5jb25mLT5k
dWFsX2VkZ2UpCj4gKwkJbXRrX2RwaV9lbmFibGVfZHVhbF9lZGdlKGRwaSk7Cj4gIAltdGtfZHBp
X3N3X3Jlc2V0KGRwaSwgZmFsc2UpOwo+ICAKPiAgCXJldHVybiAwOwoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QK
ZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9w
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
