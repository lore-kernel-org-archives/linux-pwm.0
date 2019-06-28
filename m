From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v5 1/3] dt-bindings: display: mediatek: update dsi supported
 chips
Date: Fri, 28 Jun 2019 14:20:38 +0800
Message-ID: <1561702838.18399.10.camel@mtksdaap41>
References: <20190627025901.28418-1-jitao.shi@mediatek.com>
 <20190627025901.28418-2-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190627025901.28418-2-jitao.shi@mediatek.com>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
To: Jitao Shi <jitao.shi@mediatek.com>, Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>, stonea168@163.com, dri-devel@lists.freedesktop.org, yingjoe.chen@mediatek.com, Ajay Kumar <ajaykumar.rs@samsung.com>, Vincent Palatin <vpalatin@chromium.org>, cawa.cheng@mediatek.com, Russell King <rmk+kernel@arm.linux.org.uk>, Thierry Reding <treding@nvidia.com>, linux-pwm@vger.kernel.org, arPawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-mediatek@lists.infradead.org, Andy Yan <andy.yan@rock-chips.com>, Matthias Brugger <matthias.bgg@gmail.com>, eddie.huang@mediatek.com, linux-arm-kernel@lists.infradead.org, Rahul Sharma <rahul.sharma@samsung.com>, srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>, Sean Paul <seanpaul@chromium.org>
List-Id: linux-pwm@vger.kernel.org

SGksIEppdGFvOgoKT24gVGh1LCAyMDE5LTA2LTI3IGF0IDEwOjU4ICswODAwLCBKaXRhbyBTaGkg
d3JvdGU6Cj4gVXBkYXRlIGRldmljZSB0cmVlIGJpbmRpbmcgZG9jdW1lbnRhdGlvbiBmb3IgdGhl
IGRzaSBmb3IKPiBNZWRpYXRlayBNVDgxODMgU29Dcy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBKaXRh
byBTaGkgPGppdGFvLnNoaUBtZWRpYXRlay5jb20+Cj4gQWNrZWQtYnk6IFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+CgpUaGlzIHZlcnNpb24gaXMgZGlmZmVyZW50IHRoYW4gcHJldmlvdXMg
dmVyc2lvbiwgc28gSSB0aGluayB5b3Ugc2hvdWxkCnJlbW92ZSB0aGUgQWNrZWQtYnkgdGFnLiBP
ciBSb2IgY291bGQgZ2l2ZSBhIHRhZyBhZ2FpbiBvbiB0aGlzIHBhdGNoLgoKUmVnYXJkcywKQ0sK
Cj4gLS0tCj4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0
ZWssZHNpLnR4dCAgICAgfCA0ICsrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygr
KSwgMiBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL2Rpc3BsYXkvbWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dCBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9kaXNwbGF5L21lZGlhdGVrL21lZGlhdGVrLGRzaS50
eHQKPiBpbmRleCBmYWRmMzI3YzdjZGYuLmExOWE2Y2MzNzVlZCAxMDA2NDQKPiAtLS0gYS9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZGlzcGxheS9tZWRpYXRlay9tZWRpYXRlayxk
c2kudHh0Cj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2Rpc3BsYXkv
bWVkaWF0ZWsvbWVkaWF0ZWssZHNpLnR4dAo+IEBAIC03LDcgKzcsNyBAQCBjaGFubmVsIG91dHB1
dC4KPiAgCj4gIFJlcXVpcmVkIHByb3BlcnRpZXM6Cj4gIC0gY29tcGF0aWJsZTogIm1lZGlhdGVr
LDxjaGlwPi1kc2kiCj4gLSAgdGhlIHN1cHBvcnRlZCBjaGlwcyBhcmUgbXQyNzAxIGFuZCBtdDgx
NzMuCj4gKyAgdGhlIHN1cHBvcnRlZCBjaGlwcyBhcmUgbXQyNzAxLCBtdDgxNzMgYW5kIG10ODE4
My4KPiAgLSByZWc6IFBoeXNpY2FsIGJhc2UgYWRkcmVzcyBhbmQgbGVuZ3RoIG9mIHRoZSBjb250
cm9sbGVyJ3MgcmVnaXN0ZXJzCj4gIC0gaW50ZXJydXB0czogVGhlIGludGVycnVwdCBzaWduYWwg
ZnJvbSB0aGUgZnVuY3Rpb24gYmxvY2suCj4gIC0gY2xvY2tzOiBkZXZpY2UgY2xvY2tzCj4gQEAg
LTI2LDcgKzI2LDcgQEAgVGhlIE1JUEkgVFggY29uZmlndXJhdGlvbiBtb2R1bGUgY29udHJvbHMg
dGhlIE1JUEkgRC1QSFkuCj4gIAo+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOgo+ICAtIGNvbXBhdGli
bGU6ICJtZWRpYXRlayw8Y2hpcD4tbWlwaS10eCIKPiAtICB0aGUgc3VwcG9ydGVkIGNoaXBzIGFy
ZSBtdDI3MDEgYW5kIG10ODE3My4KPiArICB0aGUgc3VwcG9ydGVkIGNoaXBzIGFyZSBtdDI3MDEs
IG10ODE3MyBhbmQgbXQ4MTgzLgo+ICAtIHJlZzogUGh5c2ljYWwgYmFzZSBhZGRyZXNzIGFuZCBs
ZW5ndGggb2YgdGhlIGNvbnRyb2xsZXIncyByZWdpc3RlcnMKPiAgLSBjbG9ja3M6IFBMTCByZWZl
cmVuY2UgY2xvY2sKPiAgLSBjbG9jay1vdXRwdXQtbmFtZXM6IG5hbWUgb2YgdGhlIG91dHB1dCBj
bG9jayBsaW5lIHRvIHRoZSBEU0kgZW5jb2RlcgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxpc3QKZHJpLWRldmVsQGxp
c3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNrdG9wLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2RyaS1kZXZlbA==
