From: CK Hu <ck.hu@mediatek.com>
Subject: Re: [v3 3/3] drm/mediatek: add mt8183 dpi support
Date: Tue, 7 May 2019 15:41:27 +0800
Message-ID: <1557214887.3498.7.camel@mtksdaap41>
References: <20190416055242.75764-1-jitao.shi@mediatek.com>
 <20190416055242.75764-4-jitao.shi@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <20190416055242.75764-4-jitao.shi@mediatek.com>
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
d3JvdGU6CgpJIG5lZWQgdGhlIGNvbW1pdCBtZXNzYWdlLiBFdmVuIHRob3VnaCB0aGUgY29kZSBp
cyBlYXN5IHRvIHVuZGVyc3RhbmQsCndvcmRzIGZvciB0aGlzIHBhdGNoIGlzIHN0aWxsIG5lY2Vz
c2FyeS4KClJlZ2FyZHMsCkNLCgo+IFNpZ25lZC1vZmYtYnk6IEppdGFvIFNoaSA8aml0YW8uc2hp
QG1lZGlhdGVrLmNvbT4KPiAtLS0KPiAgZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
YyB8IDE5ICsrKysrKysrKysrKysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlv
bnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGku
YyBiL2RyaXZlcnMvZ3B1L2RybS9tZWRpYXRlay9tdGtfZHBpLmMKPiBpbmRleCA2NjQwNTE1OTE0
MWEuLmZiYjA4NzIxODc3NSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vbWVkaWF0ZWsv
bXRrX2RwaS5jCj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL21lZGlhdGVrL210a19kcGkuYwo+IEBA
IC02ODEsNiArNjgxLDE2IEBAIHN0YXRpYyB1bnNpZ25lZCBpbnQgbXQyNzAxX2NhbGN1bGF0ZV9m
YWN0b3IoaW50IGNsb2NrKQo+ICAJCXJldHVybiAyOwo+ICB9Cj4gIAo+ICtzdGF0aWMgdW5zaWdu
ZWQgaW50IG10ODE4M19jYWxjdWxhdGVfZmFjdG9yKGludCBjbG9jaykKPiArewo+ICsJaWYgKGNs
b2NrIDw9IDI3MDAwKQo+ICsJCXJldHVybiA4Owo+ICsJZWxzZSBpZiAoY2xvY2sgPD0gMTY3MDAw
KQo+ICsJCXJldHVybiA0Owo+ICsJZWxzZQo+ICsJCXJldHVybiAyOwo+ICt9Cj4gKwo+ICBzdGF0
aWMgY29uc3Qgc3RydWN0IG10a19kcGlfY29uZiBtdDgxNzNfY29uZiA9IHsKPiAgCS5jYWxfZmFj
dG9yID0gbXQ4MTczX2NhbGN1bGF0ZV9mYWN0b3IsCj4gIAkucmVnX2hfZnJlX2NvbiA9IDB4ZTAs
Cj4gQEAgLTY5Miw2ICs3MDIsMTIgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYg
bXQyNzAxX2NvbmYgPSB7Cj4gIAkuZWRnZV9zZWxfZW4gPSB0cnVlLAo+ICB9Owo+ICAKPiArc3Rh
dGljIGNvbnN0IHN0cnVjdCBtdGtfZHBpX2NvbmYgbXQ4MTgzX2NvbmYgPSB7Cj4gKwkuY2FsX2Zh
Y3RvciA9IG10ODE4M19jYWxjdWxhdGVfZmFjdG9yLAo+ICsJLnJlZ19oX2ZyZV9jb24gPSAweGUw
LAo+ICsJLmR1YWxfZWRnZSA9IHRydWUsCj4gK307Cj4gKwo+ICBzdGF0aWMgaW50IG10a19kcGlf
cHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiAgewo+ICAJc3RydWN0IGRldmlj
ZSAqZGV2ID0gJnBkZXYtPmRldjsKPiBAQCAtNzg3LDYgKzgwMyw5IEBAIHN0YXRpYyBjb25zdCBz
dHJ1Y3Qgb2ZfZGV2aWNlX2lkIG10a19kcGlfb2ZfaWRzW10gPSB7Cj4gIAl7IC5jb21wYXRpYmxl
ID0gIm1lZGlhdGVrLG10ODE3My1kcGkiLAo+ICAJICAuZGF0YSA9ICZtdDgxNzNfY29uZiwKPiAg
CX0sCj4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4My1kcGkiLAo+ICsJICAuZGF0
YSA9ICZtdDgxODNfY29uZiwKPiArCX0sCj4gIAl7IH0sCj4gIH07Cj4gIAoKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmRyaS1kZXZlbCBtYWlsaW5nIGxp
c3QKZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpodHRwczovL2xpc3RzLmZyZWVkZXNr
dG9wLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2RyaS1kZXZlbA==
