From: =?utf-8?B?Vm9rw6HEjSBNaWNoYWw=?= <Michal.Vokac@ysoft.com>
Subject: Re: [RCF PATCH,v2,2/2] pwm: imx: Configure output to GPIO in disabled
 state
Date: Thu, 22 Nov 2018 16:46:39 +0000
Message-ID: <b332b319-cbb3-547f-c8b7-1dd275c1596d@ysoft.com>
References: <20181108191855.zuon3ecv4yjfbs7g@pengutronix.de>
 <283cfef3-16d0-8bd4-e306-6e34d44c3a86@ysoft.com>
 <20181109165555.vqbiwh4hlcnozdna@pengutronix.de> <20181114113449.GB2620@ulmo>
 <20181114215120.vddykljqyavm64wj@pengutronix.de> <20181115152545.GA8611@ulmo>
 <20181115203733.qvonika6yhn2bsnb@pengutronix.de>
 <20181116083430.7f1d8452@ipc1.ka-ro>
 <20181116082557.l2ljgu3hsu7tvdci@pengutronix.de>
 <91640f9b-d219-553e-043a-c6151f2f68d7@ysoft.com>
 <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122162359.ufngpgxkenlmgqni@pengutronix.de>
Content-Language: en-US
Content-ID: <1C5D3BCA2552294A8D6874CDFE1D41CB@eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@pengutronix.de>
Cc: =?utf-8?B?TG90aGFyIFdhw59tYW5u?= <LW@KARO-electronics.de>, Thierry Reding <thierry.reding@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Linus Walleij <linus.walleij@linaro.org>, viresh kumar <viresh.kumar@linaro.org>
List-Id: linux-pwm@vger.kernel.org

T24gMjIuMTEuMjAxOCAxNzoyMywgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+IEhlbGxvIE1p
Y2hhbCwNCj4gDQo+IE9uIFRodSwgTm92IDIyLCAyMDE4IGF0IDAzOjQyOjE0UE0gKzAwMDAsIFZv
a8OhxI0gTWljaGFsIHdyb3RlOg0KPj4gT24gMTYuMTEuMjAxOCAwOToyNSwgVXdlIEtsZWluZS1L
w7ZuaWcgd3JvdGU6DQo+Pj4gT24gRnJpLCBOb3YgMTYsIDIwMTggYXQgMDg6MzQ6MzBBTSArMDEw
MCwgTG90aGFyIFdhw59tYW5uIHdyb3RlOg0KPj4+PiBOby4gWW91IGNhbiBkaXNhYmxlIHRoZSBv
dXRwdXQgZHJpdmVyIHZpYSBwaW5jdHJsLCBzbyB0aGF0IG9ubHkgdGhlDQo+Pj4+IHNlbGVjdGVk
IHB1bGwtdXAvZG93biBpcyByZWxldmFudC4gVGhlIHBpbiBmdW5jdGlvbiBhbmQgR1BJTyByZWdp
c3Rlcg0KPj4+PiBzZXR0aW5ncyBkb24ndCBtYXR0ZXIgYXQgYWxsIGluIHRoaXMgY2FzZS4NCj4+
DQo+PiBMb3RoYXIsIHBsZWFzZSBjYW4geW91IGJlIG1vcmUgc3BlY2lmaWMgaG93IHdvdWxkIHlv
dSBkbyB0aGF0PyBJRkFJSyB0aGUNCj4+IHB1bGwtdXAvZG93biBpbnRlcm5hbCByZXNpc3RvcnMg
aGF2ZSBlZmZlY3Qgb25seSBpZiB0aGUgcGluIGlzIGNvbmZpZ3VyZWQNCj4+IGFzIEdQSU8gKmlu
cHV0KiAob24gaS5NWDYgYXQgbGVhc3QpLiBTZWUgdGhlIFRSTSwgMjkuNC4yLjIgT3V0cHV0IGRy
aXZlcjoNCj4+DQo+PiAgICAiSW50ZXJuYWwgcHVsbC11cCwgcHVsbC1kb3duIHJlc2lzdG9ycywg
YW5kIHBhZCBrZWVwZXIgYXJlIGRpc2FibGVkIGluDQo+PiAgICAgb3V0cHV0IG1vZGUuIg0KPj4N
Cj4+PiBJcyB0aGlzIGFib3V0IERTRT1ISS1aIGluIHRoZSBwYWQgY29udHJvbCByZWdpc3Rlcj8g
SSBkaWRuJ3Qga25vdyBhYm91dA0KPj4+IHRoaXMuIEkgc2VlIHRoaXMgZXhpc3RzIG9uIGkuTVg2
IGJ1dCBub3Qgb24gaS5NWDI1LiBBbHNvIGkuTVg1MSBkb2Vzbid0DQo+Pj4gc2VlbSB0byBoYXZl
IHRoaXMgZmVhdHVyZS4NCj4+DQo+PiBVd2UsIEkgYWxzbyBkaWQgbm90IGZpbmQgdGhlIERTRSBv
cHRpb24gb24gb3RoZXIgU29DcyBpbiB0aGVpciByZXNwZWN0aXZlDQo+PiBtYW51YWxzIGFuZCBz
b3VyY2UgY29kZS4gQnV0IGV2ZW4gaWYgaXQgd291bGQgYmUgYXZhaWxhYmxlIG9uIGFsbCBTb0Nz
DQo+PiBJIHN0aWxsIHRoaW5rIGl0IGlzIG5vdCBlbm91Z2guDQo+IA0KPiBJZiBJIHVuZGVyc3Rh
bmQgTG90aGFyIGNvcnJlY3RseSBhbmQgdGhpcyBpcyBhYm91dCB0aGUgcGFkIGNvbnRyb2wNCj4g
cmVnaXN0ZXIsIHRoZXJlIGlzIG5vIG5lZWQgZm9yIHNvZnR3YXJlIHN1cHBvcnQuIFlvdSBqdXN0
IHNwZWNpZnkgdGhlDQo+IHZhbHVlIHlvdSB3YW50IHRvIGhhdmUgd3JpdHRlbiB0byB0aGUgcGFk
IHJlZ2lzdGVyIGluIHRoZSBkZXZpY2UgdHJlZS4NCg0KSSBhZ3JlZS4gQnV0IHRoZSBwYWQgY29u
dHJvbCByZWdpc3RlciBpcyBub3QgdGhlIG9uZSB0aGF0IGNvbnRyb2xzIGlmDQp0aGUgcGFkIGlz
IGNvbmZpZ3VyZWQgYXMgaW5wdXQgb3Igb3V0cHV0LiBTbyBpZiB0aGUgcGluIGhhcHBlbnMgdG8g
YmUNCmNvbmZpZ3VyZWQgYXMgb3V0cHV0IHRoZSBwdWxsL2tlZXBlciBzZXR0aW5nIHNpbXBseSBo
YXMgbm8gZWZmZWN0Lg0KDQo+IFNvIEknZCBleHBlY3QgdGhpcyB0byByZWFsbHkgd29yayBvbiBp
Lk1YNiBidXQgbm90IHRoZSBlYXJsaWVyIFNvQ3MNCj4gd2l0aG91dCBhIGdwaW8gc3BlY2lmaWVy
Lg0KDQpNYXliZSB5b3Ugd291bGQgZXhwZWN0IGl0IHRvIHdvcmsgYnV0IEkgYWxyZWFkeSB0ZXN0
ZWQgYW5kIG1lYXN1cmVkDQp0aGF0IHdlZWtzIGFnbyA7KSBJdCBkaWQgbm90IHdvcmsuDQoNCk1p
Y2hhbA0K
