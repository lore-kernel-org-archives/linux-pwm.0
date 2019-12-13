From: Benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH] dt-bindings: pwm: fix nodename pattern
Date: Fri, 13 Dec 2019 11:09:51 +0000
Message-ID: <7b0167ca-6797-b89a-dd61-fa6db30022f7@st.com>
References: <20191211150021.20125-1-benjamin.gaignard@st.com>
 <CAL_JsqJKWoX_kY2kSieOA-wXO5xKtDbhXPMCjg-d4FHHEvOmHg@mail.gmail.com>
 <60921a82-9241-9c6e-0a17-0bd93dc52978@st.com>
 <CAL_JsqLboOKoJ0SjjS_AFkibdHzVo4tK3Z2xSUxVNBrdt5UEsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqLboOKoJ0SjjS_AFkibdHzVo4tK3Z2xSUxVNBrdt5UEsQ@mail.gmail.com>
Content-Language: en-US
Content-ID: <AD768ADD1075174EBB9969B3FA46AC4C@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Alexandre TORGUE <alexandre.torgue@st.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, Linux PWM List <linux-pwm@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pwm@vger.kernel.org

DQpPbiAxMi8xMi8xOSA4OjA3IFBNLCBSb2IgSGVycmluZyB3cm90ZToNCj4gT24gVGh1LCBEZWMg
MTIsIDIwMTkgYXQgMjoxNiBBTSBCZW5qYW1pbiBHQUlHTkFSRA0KPiA8YmVuamFtaW4uZ2FpZ25h
cmRAc3QuY29tPiB3cm90ZToNCj4+DQo+PiBPbiAxMi8xMS8xOSA4OjUyIFBNLCBSb2IgSGVycmlu
ZyB3cm90ZToNCj4+PiBPbiBXZWQsIERlYyAxMSwgMjAxOSBhdCA5OjAwIEFNIEJlbmphbWluIEdh
aWduYXJkDQo+Pj4gPGJlbmphbWluLmdhaWduYXJkQHN0LmNvbT4gd3JvdGU6DQo+Pj4+IFR5cGlj
YWwgcHdtIG5vZGVzIHNob3VsZCBiZSBuYW1lZCBwd21AeHh4Lg0KPj4+PiBUaGUgcGF0dGVybiBz
aG91bGRuJ3QgbWF0Y2ggbm9kZXMgbmFtZWQgcHdtLXh4eCB0byBhdm9pZA0KPj4+PiBjb25mbGlj
dHMgd2l0aCBwaW5tdXggb3IgcHdtLWZhbiBub2Rlcy4NCj4+PiBJdCBvbmx5IG1hdGNoZXMgcHdt
LSQoYS1oZXgtbnVtYmVyKSwgbm90IGFueSBzdHJpbmcsIHNvIHRoYXQgc2hvdWxkbid0DQo+Pj4g
YmUgYSBwcm9ibGVtLiBUaGlzIGlzIG5lZWRlZCBmb3IgdGhpbmdzIGxpa2UgR1BJTyBiYXNlZCBk
ZXZpY2VzIChub3QNCj4+PiBqdXN0IFBXTXMpIHdoaWNoIGRvbid0IGhhdmUgYW55IGFkZHJlc3Mu
DQo+Pj4NCj4+PiBQaW5tdXggbm9kZXMgYXJlIGdvaW5nIHRvIG5lZWQgdG8gYWRvcHQgc29tZSBz
b3J0IG9mIHN0YW5kYXJkIHBhdHRlcm4NCj4+PiB3ZSBjYW4gbWF0Y2ggb24uDQo+PiBJIGhhdmUg
cHVzaCBhIHBhdGNoIHRvIHN0b3AgdXNpbmcgJ0AnIGFuZCAnXycgaW4gcGlubXV4IGdyb3VwcyBu
YW1lczoNCj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNod29yay9wYXRjaC8xMTYyNTkx
Lw0KPj4gSXQgcmVtb3ZlIHRoZSB3YXJuaW5ncyB3aGVuIGNvbXBpbGluZyB0aGUgZGV2aWNldHJl
IHdpdGggVz0xMiBidXQgcHdtLnlhbWwNCj4+IGNvbXBsYWluIGJlY2F1c2UgcHdtIHBpbm11eCBp
cyBuYW1lZCBwd20tMS4NCj4+DQo+PiBIb3cgY2FuIEkgc29sdmUgdGhlc2UgaXNzdWVzIGF0IHRo
ZSBzYW1lIHRpbWUgPw0KPiBOYW1lIHRoZSBub2RlcyAqLXBpbnMgb3IgKi1waW5zLVswLTldLiBZ
b3UncmUgcHJvYmFibHkgZ29pbmcgdG8gbmVlZA0KPiBzb21lIHBhdHRlcm4gYW55d2F5cyB3aGVu
IHlvdSBkbyBhIHBpbm11eCBzY2hlbWEuDQorIEFsZXggYmVjYXVzZSB0aGF0IGltcGFjdCBwaW4g
bm9kZSBwYXR0ZXJuIGluIHN0LHN0bTMyLXBpbmN0cmwueWFtbA0KDQpCZW5qYW1pbg0KDQo+IFJv
Yg==
