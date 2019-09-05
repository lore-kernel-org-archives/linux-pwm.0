From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [PATCH v6 0/3] Support mipitx for mt8183
Date: Thu, 5 Sep 2019 10:38:20 +0800
Message-ID: <1567651100.13330.1.camel@mtksdaap41>
References: <20190807084645.63738-1-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190807084645.63738-1-jitao.shi@mediatek.com>
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

SGksIEppdGFvOgoKRm9yIHRoaXMgc2VyaWVzLCBhcHBsaWVkIHRvIG1lZGlhdGVrLWRybS1uZXh0
LTUuNSBbMV0sIHRoYW5rcy4KClsxXQpodHRwczovL2dpdGh1Yi5jb20vY2todS1tZWRpYXRlay9s
aW51eC5naXQtdGFncy9jb21taXRzL21lZGlhdGVrLWRybS1uZXh0LTUuNQoKUmVnYXJkcywKQ0sK
Ck9uIFdlZCwgMjAxOS0wOC0wNyBhdCAxNjo0NiArMDgwMCwgSml0YW8gU2hpIHdyb3RlOgo+IENo
YW5nZSBzaW5jZSB2NToKPiAgLSByZW1vdmUgbWlwaV90eC0+cmVmX2Nsawo+ICAtIHJlbW92ZSBt
dDgxODMgcGxsIHByZXBhcmUgdW5wcmVwYXJlCj4gCj4gQ2hhbmdlIHNpbmNlIHY0Ogo+ICAtIGZp
bmUgdHVuZSB0aGUgbWlwaV90eC0+cmVmX2NsayBhbmQgbWlwaV90eC0+cGxsIHNlcXVlbmNlCj4g
ICAgMS4gUHJlcGFyZSBtaXBpX3R4LT5yZWZfY2xrCj4gICAgMi4gUHJlcGFyZSBtaXBpX3R4LT5w
bGwKPiAgICAzLiBFbmFibGUgbWlwaV90eC0+cmVmX2Nsawo+ICAgIDQuIEVuYWJsZSBtaXBpX3R4
LT5wbGwKPiAKPiBDaGFuZ2VzIHNpbmNlIHYzOgo+ICAtIHR1cm4gb2ZmIFBMTCBiZWZvcmUgc2V0
dGluZyBQTEwgcGFyYW1ldGVycy4KPiAKPiBDaGFuZ2VzIHNpbmNlIHYyOgo+ICAtIHVwZGF0ZSBB
Y2tlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4KPiAgLSB1cGRhdGUgbXQ4MTgz
IG1heCBiaXQgcmF0ZSBzdXBwb3J0Cj4gCj4gQ2hhbmdlcyBzaW5jZSB2MToKPiAgLSB1cGRhdGUg
ZHQtYmluZGluZ3MgZG9jdW1lbnQgZm9yIG10ODE4MyBtaXBpdHguCj4gIC0gcmVtb3ZlIG10a19t
aXBpdHhfY2xrX2dldF9vcHMgYW5kIGFzc2lnbiBjbGtfb3BzIGluIHByb2JlLgo+ICAtIGZpeCB0
aGUgbGluY2VuY2UKPiAgLSByZW1vdmUgdHhkaXYxIGZyb20gbXRrX21pcGlfdHhfcGxsX3ByZXBh
cmUKPiAKPiBKaXRhbyBTaGkgKDMpOgo+ICAgZHQtYmluZGluZ3M6IGRpc3BsYXk6IG1lZGlhdGVr
OiB1cGRhdGUgZHNpIHN1cHBvcnRlZCBjaGlwcwo+ICAgZHJtL21lZGlhdGVrOiBzZXBhcmF0ZSBt
aXBpX3R4IHRvIGRpZmZlcmVudCBmaWxlCj4gICBkcm0vbWVkaWF0ZWs6IGFkZCBtaXBpX3R4IGRy
aXZlciBmb3IgbXQ4MTgzCj4gCj4gIC4uLi9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50
eHQgICAgICAgICB8ICAgNCArLQo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvTWFrZWZpbGUg
ICAgICAgICAgICAgfCAgIDIgKwo+ICBkcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX21pcGlf
dHguYyAgICAgICAgfCAzMzggKystLS0tLS0tLS0tLS0tLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9t
ZWRpYXRlay9tdGtfbWlwaV90eC5oICAgICAgICB8ICA0OSArKysKPiAgZHJpdmVycy9ncHUvZHJt
L21lZGlhdGVrL210a19tdDgxNzNfbWlwaV90eC5jIHwgMjg5ICsrKysrKysrKysrKysrKwo+ICBk
cml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsvbXRrX210ODE4M19taXBpX3R4LmMgfCAxNTAgKysrKysr
KysKPiAgNiBmaWxlcyBjaGFuZ2VkLCA1MTUgaW5zZXJ0aW9ucygrKSwgMzE3IGRlbGV0aW9ucygt
KQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19taXBp
X3R4LmgKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtf
bXQ4MTczX21pcGlfdHguYwo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9ncHUvZHJtL21l
ZGlhdGVrL210a19tdDgxODNfbWlwaV90eC5jCj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KZHJpLWRldmVsIG1haWxpbmcgbGlzdApkcmktZGV2ZWxA
bGlzdHMuZnJlZWRlc2t0b3Aub3JnCmh0dHBzOi8vbGlzdHMuZnJlZWRlc2t0b3Aub3JnL21haWxt
YW4vbGlzdGluZm8vZHJpLWRldmVs
