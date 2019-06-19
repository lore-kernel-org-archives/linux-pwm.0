From: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH 2/5] pwm: stm32: use 3 cells ->of_xlate()
Date: Wed, 19 Jun 2019 11:42:22 +0000
Message-ID: <c583094f-2429-d5f1-09df-fff54ab33af1@st.com>
References: <1560937925-8990-1-git-send-email-fabrice.gasnier@st.com>
 <1560937925-8990-3-git-send-email-fabrice.gasnier@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560937925-8990-3-git-send-email-fabrice.gasnier@st.com>
Content-Language: en-US
Content-ID: <25284ABC327AEA4991DCD1504D64AD22@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabrice GASNIER <fabrice.gasnier@st.com>, "thierry.reding@gmail.com" <thierry.reding@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>
List-Id: linux-pwm@vger.kernel.org

DQpPbiA2LzE5LzE5IDExOjUyIEFNLCBGYWJyaWNlIEdhc25pZXIgd3JvdGU6DQo+IFNUTTMyIFRp
bWVycyBzdXBwb3J0IGdlbmVyaWMgMyBjZWxscyBQV00gdG8gZW5jb2RlIFBXTSBudW1iZXIsIHBl
cmlvZCBhbmQNCj4gcG9sYXJpdHkuDQo+DQo+IEZpeGVzOiA3ZWRmNzM2OTIwNWIgKCJwd206IEFk
ZCBkcml2ZXIgZm9yIFNUTTMyIHBsYWZ0b3JtIikNClJldmlld2VkLWJ5OiBCZW5qYW1pbiBHYWln
bmFyZCA8YmVuamFtaW4uZ2FpZ25hcmRAc3QuY29tPg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBGYWJy
aWNlIEdhc25pZXIgPGZhYnJpY2UuZ2FzbmllckBzdC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMv
cHdtL3B3bS1zdG0zMi5jIHwgMiArKw0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KykNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcHdtL3B3bS1zdG0zMi5jIGIvZHJpdmVycy9w
d20vcHdtLXN0bTMyLmMNCj4gaW5kZXggNGY4NDI1NS4uNzQwZTJkZSAxMDA2NDQNCj4gLS0tIGEv
ZHJpdmVycy9wd20vcHdtLXN0bTMyLmMNCj4gKysrIGIvZHJpdmVycy9wd20vcHdtLXN0bTMyLmMN
Cj4gQEAgLTYwOCw2ICs2MDgsOCBAQCBzdGF0aWMgaW50IHN0bTMyX3B3bV9wcm9iZShzdHJ1Y3Qg
cGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgIAlwcml2LT5yZWdtYXAgPSBkZGF0YS0+cmVnbWFw
Ow0KPiAgIAlwcml2LT5jbGsgPSBkZGF0YS0+Y2xrOw0KPiAgIAlwcml2LT5tYXhfYXJyID0gZGRh
dGEtPm1heF9hcnI7DQo+ICsJcHJpdi0+Y2hpcC5vZl94bGF0ZSA9IG9mX3B3bV94bGF0ZV93aXRo
X2ZsYWdzOw0KPiArCXByaXYtPmNoaXAub2ZfcHdtX25fY2VsbHMgPSAzOw0KPiAgIA0KPiAgIAlp
ZiAoIXByaXYtPnJlZ21hcCB8fCAhcHJpdi0+Y2xrKQ0KPiAgIAkJcmV0dXJuIC1FSU5WQUw7
