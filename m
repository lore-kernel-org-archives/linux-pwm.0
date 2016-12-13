From: Benjamin Gaignard <benjamin.gaignard@linaro.org>
Subject: Re: [PATCH v6 3/8] PWM: add pwm-stm32 DT bindings
Date: Tue, 13 Dec 2016 17:28:36 +0100
Message-ID: <CA+M3ks6CQsOA0w82yiTaCw04e7gRwNx1mfeHanE3MDjkuX-gjg@mail.gmail.com>
References: <1481292919-26587-1-git-send-email-benjamin.gaignard@st.com>
 <1481292919-26587-4-git-send-email-benjamin.gaignard@st.com>
 <20161212190205.b5t3x6i2o7igldlo@rob-hp-laptop>
 <20161213111137.GW3625@dell.home>
 <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAL_JsqL8pJSFb8LbABAYJOQ0URaMpyupbFryk_mS2ToN1kStdA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Alexandre Torgue <alexandre.torgue@st.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Arnaud POULIQUEN <arnaud.pouliquen@st.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Thierry Reding <thierry.reding@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Peter Meerwald <pmeerw@pmeerw.net>, Hartmut Knaack <knaack.h@gmx.de>, Gerald Baeza <gerald.baeza@st.com>, Fabrice Gasnier <fabrice.gasnier@st.com>, Lee Jones <lee.jones@linaro.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Jonathan Cameron <jic23@kernel.org>, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

MjAxNi0xMi0xMyAxNjo1NyBHTVQrMDE6MDAgUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz46
Cj4gT24gVHVlLCBEZWMgMTMsIDIwMTYgYXQgNToxMSBBTSwgTGVlIEpvbmVzIDxsZWUuam9uZXNA
bGluYXJvLm9yZz4gd3JvdGU6Cj4+IE9uIE1vbiwgMTIgRGVjIDIwMTYsIFJvYiBIZXJyaW5nIHdy
b3RlOgo+Pgo+Pj4gT24gRnJpLCBEZWMgMDksIDIwMTYgYXQgMDM6MTU6MTRQTSArMDEwMCwgQmVu
amFtaW4gR2FpZ25hcmQgd3JvdGU6Cj4+PiA+IERlZmluZSBiaW5kaW5ncyBmb3IgcHdtLXN0bTMy
Cj4+PiA+Cj4+PiA+IHZlcnNpb24gNjoKPj4+ID4gLSBjaGFuZ2Ugc3QsYnJlYWtpbnB1dCBwYXJh
bWV0ZXIgZm9ybWF0IHRvIG1ha2UgaXQgdXN1YWJsZSBvbiBzdG0zMmY3IHRvby4KPj4+ID4KPj4+
ID4gdmVyc2lvbiAyOgo+Pj4gPiAtIHVzZSBwYXJhbWV0ZXJzIGluc3RlYWQgb2YgY29tcGF0aWJs
ZSBvZiBoYW5kbGUgdGhlIGhhcmR3YXJlIGNvbmZpZ3VyYXRpb24KPj4+ID4KPj4+ID4gU2lnbmVk
LW9mZi1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4KPj4+
ID4gLS0tCj4+PiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wd20vcHdtLXN0bTMyLnR4dCAg
ICAgICAgICB8IDMzICsrKysrKysrKysrKysrKysrKysrKysKPj4+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAzMyBpbnNlcnRpb25zKCspCj4+PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3B3bS9wd20tc3RtMzIudHh0Cj4+PiA+Cj4+PiA+IGRpZmYg
LS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3B3bS1zdG0zMi50
eHQgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcHdtL3B3bS1zdG0zMi50eHQK
Pj4+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPj4+ID4gaW5kZXggMDAwMDAwMC4uODY2ZjIyMgo+
Pj4gPiAtLS0gL2Rldi9udWxsCj4+PiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9wd20vcHdtLXN0bTMyLnR4dAo+Pj4gPiBAQCAtMCwwICsxLDMzIEBACj4+PiA+ICtT
VE1pY3JvZWxlY3Ryb25pY3MgU1RNMzIgVGltZXJzIFBXTSBiaW5kaW5ncwo+Pj4gPiArCj4+PiA+
ICtNdXN0IGJlIGEgc3ViLW5vZGUgb2YgYW4gU1RNMzIgVGltZXJzIGRldmljZSB0cmVlIG5vZGUu
Cj4+PiA+ICtTZWUgLi4vbWZkL3N0bTMyLXRpbWVycy50eHQgZm9yIGRldGFpbHMgYWJvdXQgdGhl
IHBhcmVudCBub2RlLgo+Pj4gPiArCj4+PiA+ICtSZXF1aXJlZCBwYXJhbWV0ZXJzOgo+Pj4gPiAr
LSBjb21wYXRpYmxlOiAgICAgICAgICAgICAgTXVzdCBiZSAic3Qsc3RtMzItcHdtIi4KPj4+ID4g
Ky0gcGluY3RybC1uYW1lczogICBTZXQgdG8gImRlZmF1bHQiLgo+Pj4gPiArLSBwaW5jdHJsLTA6
ICAgICAgICAgICAgICAgTGlzdCBvZiBwaGFuZGxlcyBwb2ludGluZyB0byBwaW4gY29uZmlndXJh
dGlvbiBub2RlcyBmb3IgUFdNIG1vZHVsZS4KPj4+ID4gKyAgICAgICAgICAgICAgICAgICBGb3Ig
UGluY3RybCBwcm9wZXJ0aWVzIHNlZSAuLi9waW5jdHJsL3BpbmN0cmwtYmluZGluZ3MudHh0Cj4+
PiA+ICsKPj4+ID4gK09wdGlvbmFsIHBhcmFtZXRlcnM6Cj4+PiA+ICstIHN0LGJyZWFraW5wdXQ6
ICAgQXJyYXlzIG9mIHRocmVlIHUzMiA8aW5kZXggbGV2ZWwgZmlsdGVyPiB0byBkZXNjcmliZSBi
cmVhayBpbnB1dCBjb25maWd1cmF0aW9ucy4KPj4+ID4gKyAgICAgICAgICAgICAgICAgICAiaW5k
ZXgiIGluZGljYXRlcyBvbiB3aGljaCBicmVhayBpbnB1dCB0aGUgY29uZmlndXJhdGlvbiBzaG91
bGQgYmUgYXBwbGllZC4KPj4+ID4gKyAgICAgICAgICAgICAgICAgICAibGV2ZWwiIGdpdmVzIHRo
ZSBhY3RpdmUgbGV2ZWwgKDA9bG93IG9yIDE9aGlnaCkgZm9yIHRoaXMgY29uZmlndXJhdGlvbi4K
Pj4+ID4gKyAgICAgICAgICAgICAgICAgICAiZmlsdGVyIiBnaXZlcyB0aGUgZmlsdGVyaW5nIHZh
bHVlIHRvIGJlIGFwcGxpZWQuCj4+PiA+ICsKPj4+ID4gK0V4YW1wbGU6Cj4+PiA+ICsgICB0aW1l
cnNANDAwMTAwMDAgewo+Pj4KPj4+IHRpbWVyQC4uLgo+Pgo+PiBObywgaXQgc2hvdWxkIGJlIHRp
bWVycy4KPgo+IFJlYWQgdGhlIHNwZWMuICJ0aW1lciIgaXMgYSBnZW5lcmljIG5vZGUgbmFtZS4g
InRpbWVycyIgaXMgbm90LiBIb3cKPiBtYW55IGlzIG5vdCByZWxldmFudC4KCiJ0aW1lciIgaXMg
YWxyZWFkeSB1c2VkIGluIHN0bTMyIERUIGZvciBjbG9ja3NvdXJjZSBub2RlLi4uIEl0IGlzIGFs
c28gd2h5CkkgdXNlICJ0aW1lcnMiIGZvciB0aGlzLgoKPgo+PiBUaGUgJ3MnIGlzIGludGVudGlv
bmFsLCBzaW5jZSB0aGlzIHBhcmVudCAoTUZEKSBkZXZpY2UgaG91c2VzIDMKPj4gZGlmZmVyZW50
IHR5cGVzIG9mIHRpbWVycy4gIFRoZSAidGltZXIiIG5vZGUgaXMgYSBjaGlsZCBvZiB0aGlzIG9u
ZS4KCgoKLS0gCkJlbmphbWluIEdhaWduYXJkCgpHcmFwaGljIFN0dWR5IEdyb3VwCgpMaW5hcm8u
b3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNvQ3MKCkZvbGxvdyBMaW5hcm86
IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0CmxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwK
