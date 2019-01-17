From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH 3/5] arm64: dts: mt7622: add a property
 "mediatek,num-pwms" for PWM
Date: Thu, 17 Jan 2019 14:00:43 +0100
Message-ID: <2edcc5fd-ce60-b585-e0fd-226897a7a34c@gmail.com>
References: <0c400cb1899c1afb4c9f021350cdc0c6ca3f6239.1547453586.git.ryder.lee@mediatek.com>
 <b5ed4626a553acb5e3107c6c96e82b674439128f.1547453586.git.ryder.lee@mediatek.com>
 <20190115200231.drn2rbxu4jxr22yz@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190115200231.drn2rbxu4jxr22yz@pengutronix.de>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>, Ryder Lee <ryder.lee@mediatek.com>
Cc: linux-pwm@vger.kernel.org, devicetree@vger.kernel.org, Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pwm@vger.kernel.org

CgpPbiAxNS8wMS8yMDE5IDIxOjAyLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToKPiBIZWxsbywK
PiAKPiBPbiBNb24sIEphbiAxNCwgMjAxOSBhdCAwNDoyMToyMlBNICswODAwLCBSeWRlciBMZWUg
d3JvdGU6Cj4+IFRoaXMgYWRkcyBhIHByb3BlcnR5ICJtZWRpYXRlayxudW0tcHdtcyIgZm9yIFBX
TSBjb250cm9sbGVyLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBt
ZWRpYXRlay5jb20+Cj4+IC0tLQo+PiAgYXJjaC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2
MjIuZHRzaSB8IDEgKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+Cj4+IGRp
ZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYyMi5kdHNpIGIvYXJj
aC9hcm02NC9ib290L2R0cy9tZWRpYXRlay9tdDc2MjIuZHRzaQo+PiBpbmRleCA4ZmM0YWE3Li5h
YjAxNmNmIDEwMDY0NAo+PiAtLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL21lZGlhdGVrL210NzYy
Mi5kdHNpCj4+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvbWVkaWF0ZWsvbXQ3NjIyLmR0c2kK
Pj4gQEAgLTQzNiw2ICs0MzYsNyBAQAo+PiAgCQkJIDwmcGVyaWNmZyBDTEtfUEVSSV9QV002X1BE
PjsKPj4gIAkJY2xvY2stbmFtZXMgPSAidG9wIiwgIm1haW4iLCAicHdtMSIsICJwd20yIiwgInB3
bTMiLCAicHdtNCIsCj4+ICAJCQkgICAgICAicHdtNSIsICJwd202IjsKPj4gKwkJbWVkaWF0ZWss
bnVtLXB3bXMgPSA8Nj47Cj4+ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7Cj4gCj4gQ29uY2VwdHVh
bGx5IHRoaXMgcGF0Y2ggbXVzdCBnbyBpbiBiZWZvcmUgdGhlIGNoYW5nZSB0byB0aGUgZHJpdmVy
Lgo+IE90aGVyd2lzZSB0aGUgcHdtcyBhcmUgbm90IHVzYWJsZSB3aXRoIG9ubHkgcGF0Y2ggMSBh
cHBsaWVkIHdoaWNoIGJyZWFrcwo+IGJpc2VjdGFiaWxpdHkuCj4gCgpUaGUgZHJpdmVyIHNob3Vs
ZCBoYXZlIGJhY2t3YXJkcyBjb21wYXRpYmlsaXR5IHRvIG9sZGVyIERUcy4gU28gdGhhdCB3b3Vs
ZCBuZWVkCnRvIGJlIGZpeGVkIGluIHRoZSBkcml2ZXIgbm90IGluIHRoZSBwYXRjaCBvcmRlciBv
ZiB0aGUgc2VyaWVzLgoKUmVnYXJkcywKTWF0dGhpYXMKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0Cmxp
bnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFk
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
