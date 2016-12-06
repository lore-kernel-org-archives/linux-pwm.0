From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 7/7] ARM: dts: stm32: add stm32 general purpose timer
 driver in DT
Date: Tue, 6 Dec 2016 09:48:35 +0000
Message-ID: <20161206094835.GB25385@dell.home>
References: <1480673842-20804-1-git-send-email-benjamin.gaignard@st.com>
 <1480673842-20804-8-git-send-email-benjamin.gaignard@st.com>
 <20161202132251.GL2683@dell>
 <e15186cb-a93e-c2e7-13bb-6704be5e8949@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <e15186cb-a93e-c2e7-13bb-6704be5e8949@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Alexandre Torgue <alexandre.torgue@st.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, lars@metafoo.de, pmeerw@pmeerw.net, linux-pwm@vger.kernel.org, linux-iio@vger.kernel.org, linus.walleij@linaro.org, arnaud.pouliquen@st.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org, thierry.reding@gmail.com, linux-arm-kernel@lists.infradead.org, Benjamin Gaignard <benjamin.gaignard@linaro.org>, knaack.h@gmx.de, gerald.baeza@st.com, fabrice.gasnier@st.com, linaro-kernel@lists.linaro.org, jic23@kernel.org, Benjamin Gaignard <benjamin.gaignard@st.com>
List-Id: linux-pwm@vger.kernel.org

T24gTW9uLCAwNSBEZWMgMjAxNiwgQWxleGFuZHJlIFRvcmd1ZSB3cm90ZToKPiBPbiAxMi8wMi8y
MDE2IDAyOjIyIFBNLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBPbiBGcmksIDAyIERlYyAyMDE2LCBC
ZW5qYW1pbiBHYWlnbmFyZCB3cm90ZToKPiA+IAo+ID4gPiBBZGQgZ2VuZXJhbCBwdXJwb3NlIHRp
bWVycyBhbmQgaXQgc3ViLW5vZGVzIGludG8gRFQgZm9yIHN0bTMyZjQuCj4gPiA+IERlZmluZSBh
bmQgZW5hYmxlIHB3bTEgYW5kIHB3bTMgZm9yIHN0bTMyZjQ2OSBkaXNjb3ZlcnkgYm9hcmQKPiA+
ID4gCj4gPiA+IHZlcnNpb24gMzoKPiA+ID4gLSB1c2UgInN0LHN0bTMyLXRpbWVyLXRyaWdnZXIi
IGluIERUCj4gPiA+IAo+ID4gPiB2ZXJzaW9uIDI6Cj4gPiA+IC0gdXNlIHBhcmFtZXRlcnMgdG8g
ZGVzY3JpYmUgaGFyZHdhcmUgY2FwYWJpbGl0aWVzCj4gPiA+IC0gZG8gbm90IHVzZSByZWZlcmVu
Y2VzIGZvciBwd20gYW5kIGlpbyB0aW1lciBzdWJub2Rlcwo+ID4gPiAKPiA+ID4gU2lnbmVkLW9m
Zi1ieTogQmVuamFtaW4gR2FpZ25hcmQgPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4KPiA+ID4g
LS0tCj4gPiA+ICBhcmNoL2FybS9ib290L2R0cy9zdG0zMmY0MjkuZHRzaSAgICAgIHwgMzMzICsr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiA+ID4gIGFyY2gvYXJtL2Jvb3QvZHRz
L3N0bTMyZjQ2OS1kaXNjby5kdHMgfCAgMjggKysrCj4gPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDM2
MCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpbLi4uXQoKSWYgeW91J3JlIG9ubHkgY29t
bWVudGluZyBvbiBhIGxpdHRsZSBwaWVjZSBvZiB0aGUgcGF0Y2gsIGl0J3MgYWx3YXlzCmEgZ29v
ZCBpZGVhIHRvIHRyaW0gdGhlIHJlc3QuCgo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9v
dC9kdHMvc3RtMzJmNDY5LWRpc2NvLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL3N0bTMyZjQ2OS1k
aXNjby5kdHMKPiA+ID4gaW5kZXggOGExNjNkNy4uZGY0Y2E3ZSAxMDA2NDQKPiA+ID4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvc3RtMzJmNDY5LWRpc2NvLmR0cwo+ID4gPiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9zdG0zMmY0NjktZGlzY28uZHRzCj4gPiA+IEBAIC04MSwzICs4MSwzMSBAQAo+
ID4gPiAgJnVzYXJ0MyB7Cj4gPiA+ICAJc3RhdHVzID0gIm9rYXkiOwo+ID4gPiAgfTsKPiA+ID4g
Kwo+ID4gPiArJmdwdGltZXIxIHsKPiA+ID4gKwlzdGF0dXMgPSAib2theSI7Cj4gPiA+ICsKPiA+
ID4gKwlwd20xQDAgewo+ID4gPiArCQlwaW5jdHJsLTAJPSA8JnB3bTFfcGlucz47Cj4gPiA+ICsJ
CXBpbmN0cmwtbmFtZXMJPSAiZGVmYXVsdCI7Cj4gPiA+ICsJCXN0YXR1cyA9ICJva2F5IjsKPiA+
ID4gKwl9Owo+ID4gPiArCj4gPiA+ICsJdGltZXIxQDAgewo+ID4gPiArCQlzdGF0dXMgPSAib2th
eSI7Cj4gPiA+ICsJfTsKPiA+ID4gK307Cj4gPiAKPiA+IFRoaXMgaXMgYSBtdWNoICpiZXR0ZXIq
IGZvcm1hdCB0aGFuIGJlZm9yZS4KPiA+IAo+ID4gSSBzdGlsbCBkb24ndCBsaWtlIHRoZSAnJicg
c3ludGF4IHRob3VnaC4KPiAKPiBQbGVhc2Uga2VlcCAiJiIgZm9ybWF0IHRvIG1hdGNoIHdpdGgg
ZXhpc3Rpbmcgbm9kZXMuCgpSaWdodC4gIEkgd2Fzbid0IHN1Z2dlc3RpbmcgdGhhdCBoZSBkaWZm
ZXJzIGZyb20gdGhlIGN1cnJlbnQgZm9ybWF0IGluCip0aGlzKiBzZXQuICBJIGFtIHN1Z2dlc3Rp
bmcgdGhhdCB3ZSBjaGFuZ2UgdGhlIGZvcm1hdCBpbiBhIHN1YnNlcXVlbnQKc2V0IHRob3VnaC4K
Cj4gPiA+ICsmZ3B0aW1lcjMgewo+ID4gPiArCXN0YXR1cyA9ICJva2F5IjsKPiA+ID4gKwo+ID4g
PiArCXB3bTNAMCB7Cj4gPiA+ICsJCXBpbmN0cmwtMAk9IDwmcHdtM19waW5zPjsKPiA+ID4gKwkJ
cGluY3RybC1uYW1lcwk9ICJkZWZhdWx0IjsKPiA+ID4gKwkJc3RhdHVzID0gIm9rYXkiOwo+ID4g
PiArCX07Cj4gPiA+ICsKPiA+ID4gKwl0aW1lcjNAMCB7Cj4gPiA+ICsJCXN0YXR1cyA9ICJva2F5
IjsKPiA+ID4gKwl9Owo+ID4gPiArfTsKPiA+IAoKLS0gCkxlZSBKb25lcwpMaW5hcm8gU1RNaWNy
b2VsZWN0cm9uaWNzIExhbmRpbmcgVGVhbSBMZWFkCkxpbmFyby5vcmcg4pSCIE9wZW4gc291cmNl
IHNvZnR3YXJlIGZvciBBUk0gU29DcwpGb2xsb3cgTGluYXJvOiBGYWNlYm9vayB8IFR3aXR0ZXIg
fCBCbG9nCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdApsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1hcm0ta2VybmVsCg==
